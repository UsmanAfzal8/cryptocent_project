import 'dart:convert';
import 'package:crypto_cent/Models/order_history_model.dart';
import 'package:crypto_cent/Utils/color.dart';
import 'package:crypto_cent/Utils/url.dart';
import 'package:crypto_cent/widgets/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../Authentication/SignUp/signup_screen.dart';
import '../../Home/DrawerScreens/MoreItems/user_feedback_screen.dart';
import 'order_detail_screen.dart';
import 'order_history_screen.dart';

class RunningOrdersScreen extends StatefulWidget {
  const RunningOrdersScreen({Key? key}) : super(key: key);

  @override
  State<RunningOrdersScreen> createState() => _RunningOrdersScreenState();
}

class _RunningOrdersScreenState extends State<RunningOrdersScreen> {

  List<OrderHistoryData> orderHistoryModelObjectRunning = [];
  bool mainLoader = true;
  int orderStatus = 0;

  callOrderHistoryApi(String token) async {
    setState(() {
      mainLoader = true;
    });
    http.Response response = await http.post(Uri.parse(orderHistoryApiUrl+userId),
        body: {
          'status': orderStatus.toString()
        },
        headers: {
          'Authorization': 'Bearer $token',
          'Accept' : 'application/json'
        });
    Map jsonData = jsonDecode(response.body);
    if(jsonData["message"] == "All pending orders"){
      print("All pending orders");
    }

    print("orderHistoryApi: ${orderHistoryApiUrl+userId}");
    print("orderStatus: ${orderStatus.toString()}");
    if (response.statusCode == 200) {
      for (int i = 0; i < jsonData['data'].length; i++) {
        Map<String, dynamic> obj = jsonData['data'][i];
        var pos = OrderHistoryData();
        pos = OrderHistoryData.fromJson(obj);
        orderHistoryModelObjectRunning.add(pos);
      }
      print("orderHistoryLength: ${orderHistoryModelObjectRunning.length}");
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
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey.shade100,
              child: mainLoader? Center(child: CircularProgressIndicator()):
              orderHistoryModelObjectRunning.length < 1 ? Center(child: Text("No data ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))):
              ListView.builder(
                  itemCount: orderHistoryModelObjectRunning.length,
                  itemBuilder: (context, index){

                    var dateTimeConverted = DateTime.parse(orderHistoryModelObjectRunning[index].createdAt!);
                    forMateDate = myFormat.format(dateTimeConverted);
                    print('now RunningScreen date has been converted ${forMateDate}');
                    print("productImage: ${productBaseUrl+ orderHistoryModelObjectRunning[index].checkoutProducts![0].product!.myImages![0]}");
                    print("productId: ${orderHistoryModelObjectRunning[index].checkoutProducts![0].productId!}");
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => OrderDetailScreen()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10), color: kWhite),
                        padding: EdgeInsets.all(16),
                        margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(05),
                              child: Image(
                                fit: BoxFit.fill,
                                width: MediaQuery.of(context).size.width * 0.25,
                                height: MediaQuery.of(context).size.height * 0.12,
                                image: NetworkImage(
                                    productBaseUrl + "${orderHistoryModelObjectRunning[index].checkoutProducts![0].product!.myImages![0]}"),
                              ),
                            ),

                            SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text("Id: ${orderHistoryModelObjectRunning[index].checkoutProducts![0].productId}",
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                Text("GrossTotal: ${orderHistoryModelObjectRunning[index].grossTotal}",
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                Text("Items (${orderHistoryModelObjectRunning[index].quantity})",
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
          ],
        )),
      ),
    );
  }
}
