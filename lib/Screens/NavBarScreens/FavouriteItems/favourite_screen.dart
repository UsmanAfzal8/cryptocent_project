import 'dart:convert';
import 'package:crypto_cent/Utils/color.dart';
import 'package:crypto_cent/Utils/url.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../Models/favouite_model.dart';
import '../../Authentication/SignUp/signup_screen.dart';
import '../Home/product_detail_screen.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  bool loading = true;

  getSharedPreference() async {
    setState(() {
      loading = true;
    });
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userToken = sharedPreferences.getString('userToken');
    userId = sharedPreferences.getString('userId');

    print('token==$userToken');
    print('id==$userId');
    callFavoriteItemApi();
    // setState(() {
    //   loading = false;
    // });
  }

  List<FavoriteProductsData> favoriteDataObject = [];
  callFavoriteItemApi() async {
    setState(() {
      loading = true;
    });
    http.Response response =
        await http.post(Uri.parse(favouriteProductUrl), body: {
      "user_id": userId,
    }, headers: {
      'Authorization': 'Bearer $userToken',
      "Accept": "application/json",
    });
    print("favItemApi: ${favouriteProductUrl}");
    print("myUserId: $userId");
    print("responseBody: ${response.body}");
    Map jsonData = jsonDecode(response.body);
    print("jsonResponse ${jsonData.toString()}");
    if (response.statusCode == 200) {
      for (int i = 0; i < jsonData['data'].length; i++) {
        Map<String, dynamic> obj = jsonData['data'][i];
        var pos = FavoriteProductsData();
        pos = FavoriteProductsData.fromJson(obj);
        favoriteDataObject.add(pos);
        print("favoriteLength: ${favoriteDataObject.length}");
        print(
            "favoriteImages: ${productBaseUrl + favoriteDataObject[i].product!.myFavImages![0]}");
      }
    }
    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getSharedPreference();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Favourite Items",
            style: TextStyle(color: kBlack),
          ),
          centerTitle: true,
          backgroundColor: kWhite,
          iconTheme: IconThemeData(color: kBlack),
          automaticallyImplyLeading: false,
          elevation: 2,
          leading: GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: const Icon(Icons.menu)),
        ),
        backgroundColor: Colors.white,
        body: loading
            ? Center(child: CircularProgressIndicator())
            : favoriteDataObject.length < 1
                ? Center(
                    child: Text(
                      'No favourite product found!',
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.83,
                          color: Colors.grey.shade100,
                          margin:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 05),
                          child: ListView.builder(
                              itemCount: favoriteDataObject.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              // physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProductDetailScreen(
                                                  productId:
                                                      favoriteDataObject[index]
                                                          .id
                                                          .toString(),
                                                  productTitle:
                                                      favoriteDataObject[index]
                                                          .product!
                                                          .title,
                                                  productDescription:
                                                      favoriteDataObject[index]
                                                          .product!
                                                          .description,
                                                  productImage:
                                                      favoriteDataObject[index]
                                                          .product!
                                                          .myFavImages![0],
                                                  productPrice:
                                                      favoriteDataObject[index]
                                                          .product!
                                                          .price,
                                                  productReviews:
                                                      favoriteDataObject[index]
                                                          .product!
                                                          .review,
                                                )));
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 0),
                                      // margin: EdgeInsets.only(
                                      //     right: MediaQuery.of(context).size.width * 0.02),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(05),
                                              child: FadeInImage(
                                                placeholder: AssetImage(
                                                    "assets/icons/fade_in_image.jpeg"),
                                                fit: BoxFit.fill,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.3,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.12,
                                                image: NetworkImage(productBaseUrl +
                                                    "${favoriteDataObject[index].product!.myFavImages![0]}"),
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      1.8,
                                                  child: Text(
                                                    favoriteDataObject[index]
                                                        .product!
                                                        .title!,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.01,
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      1.8,
                                                  child: Text(
                                                    "Reviews " +
                                                        favoriteDataObject[
                                                                index]
                                                            .product!
                                                            .review
                                                            .toString(),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.01,
                                                ),
                                                Text(
                                                  '\$' +
                                                      favoriteDataObject[index]
                                                          .product!
                                                          .price
                                                          .toString(),
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
