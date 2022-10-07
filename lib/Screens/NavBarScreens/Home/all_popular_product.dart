import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../Models/popular_model.dart';
import '../../../Utils/color.dart';
import '../../../Utils/url.dart';
import '../Home/product_detail_screen.dart';

class AllPopularProductsScreen extends StatefulWidget {
  const AllPopularProductsScreen({Key? key}) : super(key: key);

  @override
  State<AllPopularProductsScreen> createState() => _AllPopularProductsScreen();
}

class _AllPopularProductsScreen extends State<AllPopularProductsScreen> {
  List<PopularModel> _popular = [];
  var userToken;
  bool mainLoader = true;

  callPopularApi(String token) async {
    http.Response response = await http.get(Uri.parse(popularProductUrl),
        headers: {'Authorization': 'Bearer $token'});
    Map jsonData = jsonDecode(response.body);
    print("popularProductUrl: $popularProductUrl");
    if (response.statusCode == 200) {
      for (int i = 0; i < jsonData['show'].length; i++) {
        Map<String, dynamic> obj = jsonData['show'][i];

        var pos = PopularModel();
        pos = PopularModel.fromJson(obj);
        _popular.add(pos);
        print("popularProductLength: ${_popular.length}");
      }
      setState(() {
        mainLoader = false;
      });
    }
  }

  getSharedPreference() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userToken = sharedPreferences.getString('userToken');
    callPopularApi(userToken);
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
          title: Text("Popular Products", style: TextStyle(color: kBlack),),
          centerTitle: true,
          backgroundColor: kWhite,
          iconTheme: IconThemeData(color: kBlack),
          automaticallyImplyLeading: false,
          elevation: 2,
          leading:  GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                  height: 20, width: 20, color: Colors.transparent,
                  child: const Icon(CupertinoIcons.back))),
        ),

        body: mainLoader ? Center(child: CircularProgressIndicator(),):
        _popular.length < 1 ? Center(child: Text("No Popular products found",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),))
            : SingleChildScrollView(
                child: Column(
                children: [
                  // Container(
                  //   margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       GestureDetector(
                  //           onTap: () {
                  //             Navigator.pop(context);
                  //           },
                  //           child: const Icon(CupertinoIcons.back)),
                  //       const Text(
                  //         'Popular Products',
                  //         style: TextStyle(
                  //             fontSize: 18, fontWeight: FontWeight.w500),
                  //       ),
                  //       const Icon(CupertinoIcons.ellipsis_vertical)
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
                  Container(child: PopularProduct()),
                ],
              )),
      ),
    );
  }

  Widget PopularProduct() {
    return Container(
        height: MediaQuery.of(context).size.height * 0.89,
        margin: EdgeInsets.only(right: 10, left: 10,top: 10, bottom: 10),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 6.0,
              crossAxisSpacing: 6.0,
              childAspectRatio: 0.8,
            ),
            itemCount: _popular.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context) => ProductDetailScreen(
                            productId: _popular[index].id.toString(),
                            productTitle: _popular[index].title,
                            productDescription: _popular[index].description,
                            productImage: _popular[index].productimageList![0],
                            productPrice: _popular[index].price,
                            productReviews: _popular[index].review,
                          )));
                },
                child: Container(
                  padding: const EdgeInsets.all(6),
                  width: MediaQuery.of(context).size.width / 2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), color: cyanColor),
                  child: Column(
                    children: [
                       ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image(
                            fit: BoxFit.fill,
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.12,
                            image: NetworkImage(
                                productBaseUrl + _popular[index].productimageList![0])
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                      Container(
                          alignment: Alignment.bottomLeft,
                          width: MediaQuery.of(context).size.width / 2.4,
                          child: Text(
                            _popular[index].title.toString(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                              Text(_popular[index].review.toString() + ' reviews',
                                style: TextStyle(fontSize: 14),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.01,
                              ),
                              Text(
                                '\$' + _popular[index].price.toString(),
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.01,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (_popular[index].favourite == true) {
                                setState(() {
                                  _popular[index].favourite = false;
                                });
                              } else {
                                setState(() {
                                  _popular[index].favourite = true;
                                });
                              }

                              callPopularApi(_popular[index].id.toString());
                            },
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black45),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: _popular[index].favourite == true
                                  ? Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                                  : Icon(
                                Icons.favorite_outline,
                                color: Colors.grey,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            }));
  }
}
