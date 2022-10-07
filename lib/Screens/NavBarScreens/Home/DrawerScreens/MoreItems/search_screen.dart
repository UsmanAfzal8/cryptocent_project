import 'package:crypto_cent/Models/search_product_model.dart';
import 'package:crypto_cent/Utils/color.dart';
import 'package:crypto_cent/Utils/url.dart';
import 'package:crypto_cent/widgets/toast_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../product_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<SearchProductModel> searchProductModelObject = [];

  var userToken;
  var userId;
  bool mainLoader = false;
  bool isFound = false;
  bool favourite = false;
  var searchController = TextEditingController();

  callSearchApi() async {
    Map body = {
      'title': searchController.text,
    };
    http.Response response = await http.post(Uri.parse(searchProductUrl),
        body: body, headers: {
          "Authorization": "Bearer $userToken",
          "Accept": "application/json"
        }
      );
    print('he=='+response.body.toString());
    Map jsonData = jsonDecode(response.body);
    print("searchApiUrl: $searchProductUrl");
    print("jsonResponse: ${jsonData.toString()}");
    if(jsonData["message"] == "Record not found"){
      toastMessage("Record not found", Colors.red);
    }
    if (jsonData['status'] == 'error') {
      setState(() {
        mainLoader = false;
        isFound = true;
      });
    } else if (response.statusCode == 200) {
      for (int i = 0; i < jsonData['data'].length; i++) {
        Map<String, dynamic> obj = jsonData['data'][i];
        var pos = SearchProductModel();
        pos = SearchProductModel.fromJson(obj);
        searchProductModelObject.add(pos);
      }
      setState(() {
        mainLoader = false;
        isFound = false;
      });
    }
  }
  callFavouriteApi(String productId) async {
    Map body = {
      'user_id': userId,
      'product_id': productId,
    };
    http.Response response = await http.post(Uri.parse(favouriteItemImageUrl),
        body: body, headers: {
          'Authorization': 'Bearer $userToken',
        });
    Map jsonData = jsonDecode(response.body);
    print('hello==' + jsonData.toString());
    if (response.statusCode == 200) {
      if (jsonData['message'] == 'Product is marked as unfavourite.') {
        print('favourite');
        // toastMessage('Product Added to Favourite');
        setState(() {
          favourite = true;
        });
      } else if (jsonData['message'] == 'Product is marked as favourite.') {
        print('unfavourite');
        //toastMessage('Product removed from Favourite');
        setState(() {
          favourite = false;
        });
      }
    }
  }

  getSharedPreference() async {
    setState(() {
      mainLoader = true;
    });
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userToken = sharedPreferences.getString('userToken');
    userId = sharedPreferences.getString('userId');

    print('token==$userToken');
    print('id==$userId');
    callSearchApi();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        CupertinoIcons.back,
                      )),
                  const Text(
                    'Search',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Icon(
                    CupertinoIcons.ellipsis_vertical,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
            ),
            Container(
              alignment: Alignment.center,
              // height: 60,
              padding: const EdgeInsets.only(left: 20),
              margin: const EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade200),
                  borderRadius: BorderRadius.circular(40)),
              child: TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search',
                    suffixIcon: GestureDetector(
                      onTap: () {
                        print(',mmmm');
                        getSharedPreference();
                      },
                      child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: cyanColor),
                          child: Icon(
                            Icons.search,
                            size: 30,
                            color: primarycolor,
                          )),
                    )),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            mainLoader == true
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.6,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator())
                : isFound == true
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.6,
                        alignment: Alignment.center,
                        child: Text(
                          'No Product found!',
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    : latestProduct()
          ],
        ),
      ),
    ));
  }

  Widget latestProduct() {
    return Container(
        height: MediaQuery.of(context).size.height * 3.0,
        margin: EdgeInsets.only(right: 10, left: 10),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 6.0,
              crossAxisSpacing: 4.0,
              childAspectRatio: 0.7,
            ),
            itemCount: searchProductModelObject.length,
            itemBuilder: (context, index) {
              print('img=='+ productBaseUrl +searchProductModelObject[index].arrayImage![0]

                //  searchProductModelObject[index].productimage![0]
              );
              return GestureDetector(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context) => ProductDetailScreen(
                            productId: searchProductModelObject[index].id.toString(),
                            productTitle: searchProductModelObject[index].title,
                            productDescription: searchProductModelObject[index].description,
                            productImage: searchProductModelObject[index].arrayImage![0],
                            productPrice:  searchProductModelObject[index].price,
                            productReviews: searchProductModelObject[index].review,
                          )));
                },
                child: Container(
                  padding: const EdgeInsets.all(6),
                  width: MediaQuery.of(context).size.width / 2,
                  decoration: BoxDecoration(
                    color: cyanColor,
                    borderRadius: BorderRadius.circular(10), ),
                  child: Column(
                    children: [
                      Image(
                          width: MediaQuery.of(context).size.width ,
                          height: MediaQuery.of(context).size.height * 0.16,
                          fit: BoxFit.fill,
                          image: NetworkImage(
                              productBaseUrl + searchProductModelObject[index].arrayImage![0])),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                      Container(
                          alignment: Alignment.bottomLeft,
                          width: MediaQuery.of(context).size.width / 2.4,
                          child: Text(
                            searchProductModelObject[index].title.toString(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                              Row(
                                children: [
                                  Text(searchProductModelObject[index].review.toString() + ' reviews',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                              Text('\$' + searchProductModelObject[index].price.toString(),
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                          GestureDetector(
                            onTap: () {
                              if (searchProductModelObject[index].favourite == true) {
                                setState(() {
                                  searchProductModelObject[index].favourite = false;
                                });
                              } else {
                                setState(() {
                                  searchProductModelObject[index].favourite = true;
                                });
                              }

                              callFavouriteApi(searchProductModelObject[index].id.toString());
                            },
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                border: Border.all(color: Colors.black45),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: searchProductModelObject[index].favourite == true
                                  ? Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                                  : Icon(
                                Icons.favorite_outline,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          // Container(
                          //   alignment: Alignment.bottomCenter,
                          //   padding: const EdgeInsets.all(10),
                          //   decoration: BoxDecoration(
                          //     border: Border.all(color: Colors.black45),
                          //     borderRadius: BorderRadius.circular(40),
                          //   ),
                          //   child: const Icon(Icons.favorite_outline),
                          // )
                        ],
                      )
                    ],
                  ),
                ),
              );
            }));
  }
}
