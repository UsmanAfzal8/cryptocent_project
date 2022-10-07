import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../Models/latest_model.dart';
import '../../../Utils/color.dart';
import '../../../Utils/url.dart';
import '../Home/product_detail_screen.dart';

class AllLatestProductsScreen extends StatefulWidget {
  const AllLatestProductsScreen({Key? key}) : super(key: key);

  @override
  State<AllLatestProductsScreen> createState() => _AllLatestProductsScreenState();
}

class _AllLatestProductsScreenState extends State<AllLatestProductsScreen> {
  var userToken;
  bool mainLoader = true;
  List<LatestModel> _latestProducts = [];

  callLatestApi(String token) async {
    http.Response response = await http.get(Uri.parse(latestProductUrl),
        headers: {'Authorization': 'Bearer $token'});
    Map jsonData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      for (int i = 0; i < jsonData['show'].length; i++) {
        Map<String, dynamic> obj = jsonData['show'][i];

        var pos = LatestModel();
        pos = LatestModel.fromJson(obj);
        _latestProducts.add(pos);
      }
      setState(() {
        mainLoader = false;
      });
    }
  }

  getSharedPreference() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userToken = sharedPreferences.getString('userToken');
    callLatestApi(userToken);
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
          title: Text("Latest Products", style: TextStyle(color: kBlack),),
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
        _latestProducts.length < 1 ? Center(child: Text("No Latest products found",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)):
        SingleChildScrollView(
            child: Column(
          children: [
            latestProduct(),
          ],
        )),
      ),
    );
  }

  Widget latestProduct() {
    return Container(
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 10),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 6.0,
              crossAxisSpacing: 6.0,
              childAspectRatio: 0.7,
            ),
            itemCount: _latestProducts.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => ProductDetailScreen(
                        productId: _latestProducts[index].id.toString(),
                        productTitle:  _latestProducts[index].title,
                        productDescription:  _latestProducts[index].description,
                        productImage:  _latestProducts[index].productimageList![0],
                        productPrice:  _latestProducts[index].price,
                        productReviews:  _latestProducts[index].review,
                      )));
                },
                child: Container(
                  padding: const EdgeInsets.all(6),
                  width: MediaQuery.of(context).size.width / 2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: cyanColor
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image(
                            fit: BoxFit.fill,
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.12,
                            image: NetworkImage(
                                productBaseUrl + _latestProducts[index].productimageList![0])
                          //AssetImage('assets/images/chair.png'),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                      Container(
                          alignment: Alignment.bottomLeft,
                          width: MediaQuery.of(context).size.width / 2.4,
                          child: Text(
                            _latestProducts[index].title.toString(),
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
                                  Icon(Icons.star, color: primarycolor,),
                                  Text(_latestProducts[index].review.toString() + ' reviews',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                              Text('  \$' + _latestProducts[index].price.toString(),
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                          GestureDetector(
                            onTap: () {
                              if (_latestProducts[index].favourite == true) {
                                setState(() {
                                  _latestProducts[index].favourite = false;
                                });
                              } else {
                                setState(() {
                                  _latestProducts[index].favourite = true;
                                });
                              }

                              callLatestApi(_latestProducts[index].id.toString());
                            },
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black45),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: _latestProducts[index].favourite == true
                                  ? Icon(Icons.favorite, color: Colors.red,)
                                  : Icon(Icons.favorite_outline, color: Colors.grey,),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            }),
    );
  }
}
