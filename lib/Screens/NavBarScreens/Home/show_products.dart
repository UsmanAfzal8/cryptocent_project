import 'package:crypto_cent/Models/product_sub_category.dart';
import 'package:crypto_cent/Utils/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../Utils/url.dart';
import 'product_detail_screen.dart';

class ShowProductScreen extends StatefulWidget {
  final String name;
  final String id;
  const ShowProductScreen({Key? key, required this.id, required this.name})
      : super(key: key);

  @override
  State<ShowProductScreen> createState() => _ShowProductScreenState();
}

class _ShowProductScreenState extends State<ShowProductScreen> {
  List<ProductSubCategory> productSubCategory = [];
  var id;
  var userId;
  bool loadingSubCategoriesProducts = false;

  callProductApi(String token, String id) async {
    Map body = {
      'sub_category_id': id,
    };
    http.Response response = await http.post(Uri.parse(productSubCategoryUrl),
        body: body, headers: {'Authorization': 'Bearer $token'});
    Map jsonData = jsonDecode(response.body);
    print(jsonData.toString());

    if (response.statusCode == 200) {
      for (int i = 0; i < jsonData['data'].length; i++) {
        Map<String, dynamic> obj = jsonData['data'][i];
        var pos = ProductSubCategory();
        pos = ProductSubCategory.fromJson(obj);
        productSubCategory.add(pos);
      }
      setState(() {
        loadingSubCategoriesProducts = false;
      });
    }
  }

  getSharedPreference() async {
    setState(() {
      loadingSubCategoriesProducts = true;
    });
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    id = sharedPreferences.getString('userToken');
    userId = sharedPreferences.getString('userId');

    print('token==$id');
    print('id==$userId');

    callProductApi(id, '2');
  }

  @override
  void initState() {
    super.initState();
    getSharedPreference();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loadingSubCategoriesProducts
      ? Center(
    child: CircularProgressIndicator(),
      ) :
      SingleChildScrollView(
    child: Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20, top: 50),
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
              Text(
                widget.name,
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
          height: MediaQuery.of(context).size.height * 0.04,
        ),
        product(),
      ],
    ),
      ),
    );
  }

  Widget product() {
    return Container(
      // margin: const EdgeInsets.only(left: 15, right: 15),
      height: MediaQuery.of(context).size.height ,
      color: Colors.transparent,
      child: GridView.builder(
        padding: const EdgeInsets.all(4),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 5.0,
          crossAxisSpacing: 5.0,
          childAspectRatio: 0.8,
        ),
        itemCount: productSubCategory.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductDetailScreen(
                        productId: productSubCategory[index].id.toString(),
                        productTitle: productSubCategory[index].title,
                        productDescription: productSubCategory[index].description,
                        productImage: productSubCategory[index].productimageList![0],
                        productPrice: productSubCategory[index].price,
                        productReviews: productSubCategory[index].review,
                      )));
            },
            child: Container(
              padding: EdgeInsets.only(
                left: 5, right: 5, top: 5, bottom: 5),
              // alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: cyanColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(
                      fit: BoxFit.fill,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.12,
                      image: NetworkImage(productBaseUrl +
                          productSubCategory[index].productimageList![0])
                      //AssetImage('assets/images/chair.png'),
                      ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  Container(
                      color: Colors.transparent,
                      child: Text(
                        productSubCategory[index].title.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      )),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  Text(productSubCategory[index].review.toString() + ' reviews',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('\$' + productSubCategory[index].price.toString(),
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      Container(
                        height: 30, width: 30,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black45),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: productSubCategory[index].favourite == true
                            ? Center(
                          child: Icon(Icons.favorite, color: Colors.red,),                                   )
                            : Center(
                          child: Icon(Icons.favorite_outline, color: Colors.grey,),),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
