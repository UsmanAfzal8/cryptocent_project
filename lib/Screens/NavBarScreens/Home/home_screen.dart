import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:crypto_cent/Models/browse_model.dart';
import 'package:crypto_cent/Models/popular_model.dart';
import 'package:crypto_cent/Screens/NavBarScreens/Home/tabbar.dart';
import 'package:crypto_cent/widgets/check_connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Models/banner_model.dart';
import '../../../Models/category_model.dart';
import '../../../Models/latest_model.dart';
import '../../../Utils/color.dart';
import '../../../Utils/url.dart';
import '../../Authentication/SignUp/signup_screen.dart';
import '../Home/Category/category_screen.dart';
import '../Home/product_detail_screen.dart';
import '../Home/Category/sub_category_screen.dart';
import 'DrawerScreens/MoreItems/search_screen.dart';
import 'DrawerScreens/drawer_screen.dart';
import 'all_latest_products.dart';
import 'all_popular_product.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

import 'bitcoinScreeen.dart';

var user = FirebaseAuth.instance.currentUser;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool mainLoader2 = true;
  bool mainLoader3 = true;
  bool mainLoader4 = true;
  bool mainLoader5 = true;

  // var id;
  // var userId;
  bool mainLoader = true;

  bool favourite = false;

  List<CategoriesModel> _categories = [];
  List<PopularModel> _popular = [];
  List<LatestModel> _latest = [];
  List<BrowseModel> _browse = [];
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

    if (response.statusCode == 200) {
      for (int i = 0; i < jsonData['show'].length; i++) {
        Map<String, dynamic> obj = jsonData['show'][i];
        var pos = CategoriesModel();
        pos = CategoriesModel.fromJson(obj);
        _categories.add(pos);
      }
      if (mounted) {
        setState(() {
          mainLoader2 = false;
        });
      }
    }
  }

  callFavouriteApi(String productId) async {
    Map body = {
      'user_id': userId,
      'product_id': productId,
    };
    http.Response response =
        await http.post(Uri.parse(favouriteItemImageUrl), body: body, headers: {
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

  callPopularApi(String token) async {
    http.Response response = await http.get(Uri.parse(popularProductUrl),
        headers: {'Authorization': 'Bearer $token'});
    Map jsonData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      for (int i = 0; i < jsonData['show'].length; i++) {
        Map<String, dynamic> obj = jsonData['show'][i];

        var pos = PopularModel();
        pos = PopularModel.fromJson(obj);
        _popular.add(pos);
      }
      if (mounted) {
        setState(() {
          mainLoader3 = false;
        });
      }
    }
  }

  callLatestApi(String token) async {
    http.Response response = await http.get(Uri.parse(latestProductUrl),
        headers: {'Authorization': 'Bearer $token'});
    Map jsonData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      for (int i = 0; i < jsonData['show'].length; i++) {
        Map<String, dynamic> obj = jsonData['show'][i];

        var pos = LatestModel();
        pos = LatestModel.fromJson(obj);
        _latest.add(pos);
      }
      setState(() {
        mainLoader4 = false;
      });
    }
  }

  callBrowseApi(String token) async {
    http.Response response = await http.get(Uri.parse(browseProductUrl),
        headers: {'Authorization': 'Bearer $token'});
    Map jsonData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      for (int i = 0; i < jsonData['show'].length; i++) {
        Map<String, dynamic> obj = jsonData['show'][i];
        var pos = BrowseModel();
        pos = BrowseModel.fromJson(obj);
        _browse.add(pos);
      }
      setState(() {
        mainLoader5 = false;
      });
    }
  }

  getSharedPreference() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userToken = sharedPreferences.getString('userToken');
    userId = sharedPreferences.getString('userId');

    print('token==$userToken');
    print('id==$userId');

    callBannerApi(userToken);

    callCategoriesApi(userToken);

    callPopularApi(userToken);

    callLatestApi(userToken);

    callBrowseApi(userToken);
  }

  @override
  void initState() {
    super.initState();
    connection(context);
    getSharedPreference();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Image(
            fit: BoxFit.fill,
            height: 30,
            image: AssetImage('assets/images/Asset3.png')),
        centerTitle: true,
        backgroundColor: kWhite,
        iconTheme: IconThemeData(color: kBlack),
        automaticallyImplyLeading: false,
        elevation: 01,
        leading: GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: Container(
                height: 20,
                width: 20,
                color: Colors.transparent,
                child: const Icon(Icons.menu))),
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchScreen()));
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Icon(Icons.search),
              )),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute<Tabbarview>(
                builder: (BuildContext context) => const Tabbarview(),
              ));
            },
            splashRadius: 20,
            icon: Icon(
              CupertinoIcons.qrcode_viewfinder,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      drawer: DrawerScreen(),
      body: mainLoader ||
              mainLoader2 ||
              mainLoader3 ||
              mainLoader4 ||
              mainLoader5
          ? Center(child: CircularProgressIndicator())
          : Container(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Container(
                    //     margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         GestureDetector(
                    //             onTap: () {
                    //               Scaffold.of(context).openDrawer();
                    //             },
                    //             child: Icon(Icons.menu)),
                    //         Image(
                    //             fit: BoxFit.cover,
                    //             height: 30,
                    //             image: AssetImage('assets/images/Asset3.png')),
                    //         GestureDetector(
                    //             onTap: () {
                    //               Navigator.push(context, MaterialPageRoute(
                    //                       builder: (context) => SearchScreen()));
                    //             },
                    //             child: Icon(Icons.search))
                    //       ],
                    //     ),
                    //   ),
                    //   SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                    Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: CarouselSlider.builder(
                            itemCount: _banner.length,
                            options: CarouselOptions(
                              autoPlay: true,
                              enlargeCenterPage: true,
                              aspectRatio: 3.0,
                              initialPage: 0,
                            ),
                            itemBuilder: (context, index, realIndex) {
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                margin: EdgeInsets.symmetric(horizontal: 2),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                      fit: BoxFit.cover,
                                      image: NetworkImage(imgBaseUrl +
                                          _banner[index].img.toString())),
                                ),
                              );
                            })),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Category',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CategoryScreen()));
                            },
                            child: Text(
                              'View All',
                              style:
                                  TextStyle(color: primarycolor, fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    categoryDesign(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Popular Products',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AllPopularProductsScreen()));
                            },
                            child: Text(
                              'View All',
                              style:
                                  TextStyle(color: primarycolor, fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: PopularProduct(),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Latest Products',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AllLatestProductsScreen()));
                            },
                            child: Text(
                              'View All',
                              style:
                                  TextStyle(color: primarycolor, fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: LatestProduct(),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: Text(
                        'Browse',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    browseProduct(),
                  ],
                ),
              ),
            ),
    ));
  }

  Widget categoryDesign() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: MediaQuery.of(context).size.height * 0.065,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: _categories.length,
        itemBuilder: ((context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SubCategoryScreen(
                          id: _categories[index].id.toString(),
                          name: _categories[index].name.toString())));
            },
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(right: 6),
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: cyanColor,
              ),
              child: Text(
                _categories[index].name.toString(),
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget browseProduct() {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.9,
      child: mainLoader
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _browse.length < 1
              ? Center(
                  child: Container(
                  child: Text(
                    "No browse products found",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ))
              : ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: _browse.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductDetailScreen(
                                      productId: _browse[index].id.toString(),
                                      productTitle: _browse[index].title,
                                      productDescription:
                                          _browse[index].description,
                                      productImage:
                                          _browse[index].productimageList![0],
                                      productPrice: _browse[index].price,
                                      productReviews: _browse[index].review,
                                    )));
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: cyanColor),
                        margin:
                            EdgeInsets.only(left: 20, right: 20, bottom: 10),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  height:
                                      MediaQuery.of(context).size.height * 0.16,
                                  fit: BoxFit.fill,
                                  image: NetworkImage(productBaseUrl +
                                      _browse[index].productimageList![0])),
                            ),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.04),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(_browse[index].title.toString(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500)),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Reviews ' +
                                                _browse[index]
                                                    .review
                                                    .toString(),
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.01),
                                          Text(
                                            '\$' +
                                                _browse[index].price.toString(),
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05),
                                      GestureDetector(
                                        onTap: () {
                                          if (_browse[index].favourite ==
                                              true) {
                                            setState(() {
                                              _browse[index].favourite = false;
                                            });
                                          } else {
                                            setState(() {
                                              _browse[index].favourite = true;
                                            });
                                          }

                                          callFavouriteApi(
                                              _browse[index].id.toString());
                                        },
                                        child: Container(
                                          alignment: Alignment.bottomCenter,
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black45),
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                          child:
                                              _browse[index].favourite == true
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
                                  ),
                                ]),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }

  Widget PopularProduct() {
    return Container(
      margin: EdgeInsets.only(right: 10, left: 10),
      child: mainLoader
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _popular.length < 1
              ? Center(
                  child: Text(
                  "No Popular products found",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ))
              : ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: _popular.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductDetailScreen(
                                      productId: _popular[index].id.toString(),
                                      productTitle: _popular[index].title,
                                      productDescription:
                                          _popular[index].description,
                                      productImage:
                                          _popular[index].productimageList![0],
                                      productPrice: _popular[index].price,
                                      productReviews: _popular[index].review,
                                    )));
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width / 2,
                        margin: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: cyanColor),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image(
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.12,
                                  image: NetworkImage(productBaseUrl +
                                      _popular[index].productimageList![0])
                                  //AssetImage('assets/images/chair.png'),
                                  ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            Container(
                                alignment: Alignment.bottomLeft,
                                width: MediaQuery.of(context).size.width / 2.4,
                                child: Text(
                                  _popular[index].title.toString(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: primarycolor,
                                        ),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.02),
                                        Text(
                                          _popular[index].review.toString() +
                                              ' reviews',
                                          //' 12 ',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01,
                                    ),
                                    Text(
                                      '\$' + _popular[index].price.toString(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.02,
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

                                    callFavouriteApi(
                                        _popular[index].id.toString());
                                  },
                                  child: Container(
                                    alignment: Alignment.bottomCenter,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
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
                  },
                ),
    );
  }

  Widget LatestProduct() {
    return Container(
      margin: EdgeInsets.only(right: 10, left: 10),
      height: MediaQuery.of(context).size.height * 0.14,
      child: mainLoader
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _latest.length < 1
              ? Center(
                  child: Text(
                  "No Latest products found",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ))
              : ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: _latest.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductDetailScreen(
                                      productId: _latest[index].id.toString(),
                                      productTitle: _latest[index].title,
                                      productDescription:
                                          _latest[index].description,
                                      productImage:
                                          _latest[index].productimageList![0],
                                      productPrice: _latest[index].price,
                                      productReviews: _latest[index].review,
                                    )));
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width / 2,
                        margin: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: cyanColor),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image(
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.12,
                                  image: NetworkImage(productBaseUrl +
                                      _latest[index].productimageList![0])
                                  //AssetImage('assets/images/chair.png'),
                                  ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            Container(
                                alignment: Alignment.bottomLeft,
                                width: MediaQuery.of(context).size.width / 2.4,
                                child: Text(
                                  _latest[index].title.toString(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: primarycolor,
                                        ),
                                        Text(
                                          _latest[index].review.toString() +
                                              ' reviews',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01,
                                    ),
                                    Text(
                                      '  \$' + _latest[index].price.toString(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.02,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (_latest[index].favourite == true) {
                                      setState(() {
                                        _latest[index].favourite = false;
                                      });
                                    } else {
                                      setState(() {
                                        _latest[index].favourite = true;
                                      });
                                    }

                                    callFavouriteApi(
                                        _latest[index].id.toString());
                                  },
                                  child: Container(
                                    alignment: Alignment.bottomCenter,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black45),
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    child: _latest[index].favourite == true
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
                  },
                ),
    );
  }
}
