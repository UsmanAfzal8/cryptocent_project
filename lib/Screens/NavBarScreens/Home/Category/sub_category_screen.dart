import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../Models/banner_model.dart';
import '../../../../Models/show_sub_category_model.dart';
import '../../../../Utils/color.dart';
import '../../../../Utils/url.dart';
import '../show_products.dart';

class SubCategoryScreen extends StatefulWidget {
  final String id;
  final String name;
  const SubCategoryScreen({Key? key, required this.id, required this.name})
      : super(key: key);

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  var id;
  bool loadingSubCategories = false;
  var userId;
  List<ShowSubCategoryModel> _categories = [];
  List<BannerModel> _banner = [];

  callBannerApi(String token) async {
    setState(() {
      loadingSubCategories = true;
    });
    http.Response response = await http
        .get(Uri.parse(bannerUrl), headers: {'Authorization': 'Bearer $token'});
    Map jsonData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      for (int i = 0; i < jsonData['banner'].length; i++) {
        Map<String, dynamic> obj = jsonData['banner'][i];
        var pos = BannerModel();
        pos = BannerModel.fromJson(obj);
        _banner.add(pos);
      }
      setState(() {
        loadingSubCategories = false;
      });
    }
  }

  callCategoriesApi(String token) async {
    http.Response response = await http.get(
        Uri.parse(subCategoryUrl+userId),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        });
    Map jsonData = jsonDecode(response.body);

    print(jsonData.toString());
    print("subCategoryUrl ${subCategoryUrl+userId}");

    if (response.statusCode == 200) {
      for (int i = 0; i < jsonData['show_sub'].length; i++) {
        Map<String, dynamic> obj = jsonData['show_sub'][i];
        var pos = ShowSubCategoryModel();
        pos = ShowSubCategoryModel.fromJson(obj);
        _categories.add(pos);
        print("subCategory Length: ${_categories.length}");
      }
      setState(() {
        loadingSubCategories = false;
      });
    } else {
      setState(() {
        // noSubCategory = true;
        loadingSubCategories = false;
      });
    }
  }

  getSharedPreference() async {
    setState(() {
      loadingSubCategories = true;
    });
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    id = sharedPreferences.getString('userToken');
    userId = sharedPreferences.getString('userId');

    print('token==$id');
    print('id==$userId');
    print('id2===' + widget.id.toString());


    callBannerApi(id).then((value){
      setState(() {
        callCategoriesApi(id);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getSharedPreference();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
           title: Text(widget.name,
          style: TextStyle( color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(CupertinoIcons.back, color: Colors.black,)),
        actions: [
          Icon(CupertinoIcons.ellipsis_vertical, color: Colors.black,),
        ],
      ),

      body: loadingSubCategories ? Center(child: CircularProgressIndicator()):
      // _categories.length < 1 ? Center(child: Text("No Subcategory found",
      //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)):
        SingleChildScrollView(
          child: Column(
            children: [
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
                          margin: EdgeInsets.symmetric(horizontal: 1),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image(
                                fit: BoxFit.cover,
                                image: NetworkImage(imgBaseUrl + _banner[index].img.toString())),
                          ),
                        );
                      })),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
              loadingSubCategories ? Center(child: CircularProgressIndicator(),):
              _categories.length < 1 ? Container(
                height: MediaQuery.of(context).size.height * 0.65,
                color: Colors.transparent,
                child: Center(child: Text("No Subcategory found",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),)),
              )
                  : subCategoryDesign(),
            ],
          ),
        ),
    );
  }

  Widget subCategoryDesign() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 4, mainAxisSpacing: 4),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ShowProductScreen(
                            id: _categories[index].id.toString(),
                            name: _categories[index].name.toString(),
                          )));
            },
            child: Container(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Opacity(
                      opacity: 0.2,
                      child: Image(
                          height: MediaQuery.of(context).size.height * 0.2,
                          fit: BoxFit.fill,
                          image: NetworkImage(productBaseUrl + _categories[index].catImg.toString())),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      _categories[index].name.toString(),
                      style: TextStyle(fontSize: 18, color: kBlack),
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
