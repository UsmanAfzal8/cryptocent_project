import 'dart:convert';

import 'package:crypto_cent/Models/checkout_model.dart';
import 'package:crypto_cent/Utils/url.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../Models/checkout_details_model.dart';
import '../../../../Utils/color.dart';
import 'package:http/http.dart' as http;
import '../../../Authentication/SignUp/signup_screen.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({Key? key}) : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
bool loading = false;

  List<checkOutDetailsModel> checkOutDataObject = [];
  callCheckOutDetailsApi() async {
    setState(() {
      loading = true;
    });
    http.Response response = await http.get(Uri.parse(checkOutDetailsApiUrl),
        headers:{
          'Authorization': 'Bearer $userToken',
          "Accept": "application/json",
        });
    print("checkOutDetailsApi: ${checkOutDetailsApiUrl}");
    print("myUserId: $userId");
    Map jsonData = jsonDecode(response.body);
    print("jsonResponse ${jsonData.toString()}");
    if (response.statusCode == 200) {
      for (int i = 0; i < jsonData['data'].length; i++) {
        Map<String, dynamic> obj = jsonData['data'][i];
        var pos = checkOutDetailsModel();
        pos = checkOutDetailsModel.fromJson(obj);
        checkOutDataObject.add(pos);
        print("checkOutDetailsLength: ${checkOutDataObject.length}");
        // print("favoriteImages: ${productBaseUrl + favoriteDataObject[i].product!.myFavImages![0]}");
      }
    }
    setState(() {
      loading = false;
    });
  }

getSharedPreference() async {
  setState(() {
    loading = true;
  });
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  userToken = sharedPreferences.getString('userToken');
  userId = sharedPreferences.getString('userId');

  print('token==$userToken');
  print('id==$userId');
  callCheckOutDetailsApi();
}
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPreference();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          iconTheme: IconThemeData(color: kBlack),
          title: Text('Order Details',
            style: TextStyle(color: kBlack, fontSize: 20),
          ),
          backgroundColor: kWhite,
        ),
        body: loading ? Center(child: CircularProgressIndicator())
            : checkOutDataObject.length < 1 ?  Center(
          child: Text('No details found!',
            style: TextStyle(color: Colors.black),
          ),
        ) :
        SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Order ID: ${checkOutDataObject[0].id}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              color: Colors.transparent,
              child: ListView.builder(
                  itemCount: checkOutDataObject.length,
                  itemBuilder: (context, index){
                return Container(
                  // margin: EdgeInsets.symmetric(horizontal: 05, vertical: 2),
                  // padding: EdgeInsets.all(10),
                  //color: Colors.red,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 05, vertical: 07),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Order ID: ${checkOutDataObject[index].id}',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.01,
                              ),
                              Text(
                                '${checkOutDataObject[index].product!.title}',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.01,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width /1.8,
                                child: Text("Reviews " +checkOutDataObject[index].product!.review.toString(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.01,
                              ),
                              Text(
                                '\$ ${checkOutDataObject[index].product!.price}',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(05),
                            child: FadeInImage(
                              placeholder: AssetImage("assets/icons/fade_in_image.jpeg"),
                              fit: BoxFit.fill,
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: MediaQuery.of(context).size.height * 0.12,
                              image: NetworkImage(
                                  productBaseUrl + "${checkOutDataObject[index].product!.myCheckOutImages![0]}"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        )),
      ),
    );
  }

  Widget orderDetail() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: EdgeInsets.all(10),
      //color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Digital Clock',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Container(
                // width: MediaQuery.of(context).size.width / 1.4,
                child: Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: primarycolor,
                    ),
                    Icon(
                      Icons.star,
                      color: primarycolor,
                    ),
                    Icon(
                      Icons.star,
                      color: primarycolor,
                    ),
                    Icon(
                      Icons.star,
                      color: primarycolor,
                    ),
                    Icon(
                      Icons.star,
                      color: primarycolor,
                    ),
                    Container(
                      //   width: MediaQuery.of(context).size.width * 0.3,
                      child: const Text(
                        '  (17 reviews)',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              const Text(
                '\$650.0',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: MediaQuery.of(context).size.height * 0.12,
              width: MediaQuery.of(context).size.width * 0.24,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade300),
              child: const CircleAvatar(
                radius: 26,
                backgroundImage: AssetImage('assets/images/food.jpeg'),
              )),
        ],
      ),
    );
  }
}
