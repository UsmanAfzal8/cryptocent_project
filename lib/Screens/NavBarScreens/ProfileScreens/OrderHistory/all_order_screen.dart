import 'dart:convert';
import 'package:crypto_cent/Models/order_history_model.dart';
import 'package:crypto_cent/Screens/Authentication/SignUp/signup_screen.dart';
import 'package:crypto_cent/Utils/color.dart';
import 'package:crypto_cent/Utils/url.dart';
import 'package:crypto_cent/widgets/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../Home/DrawerScreens/MoreItems/user_feedback_screen.dart';
import 'order_detail_screen.dart';
import 'order_history_screen.dart';

class AllOrdersScreen extends StatefulWidget {
  const AllOrdersScreen({Key? key}) : super(key: key);

  @override
  State<AllOrdersScreen> createState() => _AllOrdersScreenState();
}

class _AllOrdersScreenState extends State<AllOrdersScreen> {

  List<OrderHistoryData> orderHistoryModelObjectAll = [];
  bool mainLoader = false;

  int orderStatus = 2;

  callOrderHistoryApi(String token) async {
    setState(() {
      mainLoader = true;
    });
    http.Response response = await http.post(Uri.parse(orderHistoryApiUrl+userId),
        body: {
          'status': orderStatus.toString(),
        },
        headers: {
          'Authorization': 'Bearer $token',
          'Accept' : 'application/json'
        });
    Map jsonData = jsonDecode(response.body);
    if(jsonData["message"] == "All orders"){
      print("All orders");
      // toastMessage("All orders", Colors.green);
    }
    print("orderHistoryApi: ${orderHistoryApiUrl+userId}");
    print("orderStatus: ${orderStatus.toString()}");
    if (response.statusCode == 200) {
      for (int i = 0; i < jsonData['data'].length; i++) {
        Map<String, dynamic> obj = jsonData['data'][i];
        var pos = OrderHistoryData();
        pos = OrderHistoryData.fromJson(obj);
        orderHistoryModelObjectAll.add(pos);
        print("orderHistoryLength: ${orderHistoryModelObjectAll.length}");
      }
      setState(() {
        mainLoader = false;
      });
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

    // setState(() {
    //   mainLoader = false;
    // });
    //
    callOrderHistoryApi(userToken);
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
        body: mainLoader? Center(child: CircularProgressIndicator()):
        orderHistoryModelObjectAll.length < 1 ? Center(child: Text("No data ",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))):
        Container(
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey.shade100,
          child: ListView.builder(
              itemCount: orderHistoryModelObjectAll.length,
              // reverse: true,
              itemBuilder: (context, index){
                var dateTimeConverted = DateTime.parse(orderHistoryModelObjectAll[index].createdAt!);
                forMateDate = myFormat.format(dateTimeConverted);
                print('now date has been converted ${forMateDate}');
                print("productImage: ${productBaseUrl+ orderHistoryModelObjectAll[index].checkoutProducts![0].product!.myImages![0]}");
                print("productId: ${orderHistoryModelObjectAll[index].checkoutProducts![0].productId!}");
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => OrderDetailScreen()));
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: kWhite),
                padding: EdgeInsets.all(8),
                margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                      // borderRadius: BorderRadius.circular(10),
                      child: Image(
                          fit: BoxFit.fill,
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.height * 0.12,
                          image: NetworkImage(
                              productBaseUrl + "${orderHistoryModelObjectAll[index].checkoutProducts![0].product!.myImages![0]}"),
                      ),
                    ),

                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Id: ${orderHistoryModelObjectAll[index].checkoutProducts![index].productId}",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                        Text("GrossTotal: ${orderHistoryModelObjectAll[index].grossTotal}",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                        Text("Items (${orderHistoryModelObjectAll[index].quantity})",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                        Text(forMateDate.toString(),
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                      ],
                    ),

                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
