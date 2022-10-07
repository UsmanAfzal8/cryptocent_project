import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:crypto_cent/Models/banner_model.dart';
import 'package:crypto_cent/Models/category_model.dart';
import 'package:crypto_cent/Utils/color.dart';
import 'package:crypto_cent/Utils/url.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'sub_category_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  var id;
  bool mainLoader = true;
  var userId;
  List<CategoriesModel> _categories = [];
  List<BannerModel> _banner = [];

  callBannerApi(String token) async {
    http.Response response = await http
        .get(Uri.parse(bannerUrl), headers: {'Authorization': 'Bearer $token'});
    Map jsonData = jsonDecode(response.body);
    print(jsonData.toString());
    if (response.statusCode == 200) {
      for (int i = 0; i < jsonData['banner'].length; i++) {
        Map<String, dynamic> obj = jsonData['banner'][i];
        var pos = BannerModel();
        pos = BannerModel.fromJson(obj);
        _banner.add(pos);
      }
      setState(() {
        mainLoader = false;
      });
    }
  }

  callCategoriesApi(String token) async {
    http.Response response = await http.get(Uri.parse(categoriesUrl),
        headers: {'Authorization': 'Bearer $token'});
    Map jsonData = jsonDecode(response.body);
    print("categoriesApi: $categoriesUrl");

    if (response.statusCode == 200) {
      for (int i = 0; i < jsonData['show'].length; i++) {
        Map<String, dynamic> obj = jsonData['show'][i];
        var pos = CategoriesModel();
        pos = CategoriesModel.fromJson(obj);
        _categories.add(pos);
      }
      print("categoriesLength: ${_categories.length}");
      setState(() {
        mainLoader = false;
      });
    }
  }

  getSharedPreference() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    id = sharedPreferences.getString('userToken');
    userId = sharedPreferences.getString('userId');

    print('token==$id');
    print('id==$userId');

    callCategoriesApi(id);
    callBannerApi(id);
  }

  @override
  void initState() {
    super.initState();
    getSharedPreference();
    print("categoriesLength: ${_categories.length}");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: mainLoader
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
        height: MediaQuery.of(context).size.height ,
            // color: primarycolor,
            child: SingleChildScrollView(
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
                            'Categories',
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
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
                    Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: CarouselSlider.builder(
                            itemCount: _banner.length,
                            options: CarouselOptions(
                              autoPlay: true,
                              enlargeCenterPage: true,
                              aspectRatio: 2.0,
                              initialPage: 2,
                            ),
                            itemBuilder: (context, index, realIndex) {
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 2),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(imgBaseUrl + _banner[index].img.toString())),
                                ),
                              );
                            })),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                    subCategoryDesign(),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                  ],
                ),
              ),
          ),
    ));
  }

  Widget subCategoryDesign() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      // color: primarycolor,
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 6, mainAxisSpacing: 4),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          print("categoryImage: ${categoryImageBaseUrl + _categories[index].catImg.toString()}");
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                      builder: (context) => SubCategoryScreen(
                            id: _categories[index].id.toString(),
                            name: _categories[index].name.toString())));
            },
            child: Container(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Opacity(
                      opacity: 0.2,
                      child: Image(
                          height: MediaQuery.of(context).size.height * 0.2,
                          fit: BoxFit.fill,
                          image: NetworkImage(
                              categoryImageBaseUrl + _categories[index].catImg.toString())),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      _categories[index].name.toString(),
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: kBlack),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
