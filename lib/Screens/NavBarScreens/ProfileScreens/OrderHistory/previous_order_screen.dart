import 'dart:convert';
import 'package:crypto_cent/Models/order_history_model.dart';
import 'package:crypto_cent/Utils/color.dart';
import 'package:crypto_cent/Utils/url.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../Authentication/SignUp/signup_screen.dart';
import '../../Home/DrawerScreens/MoreItems/user_feedback_screen.dart';
import 'order_history_screen.dart';

class PreviousOrderScreen extends StatefulWidget {
  const PreviousOrderScreen({Key? key}) : super(key: key);

  @override
  State<PreviousOrderScreen> createState() => _PreviousOrderScreenState();
}

class _PreviousOrderScreenState extends State<PreviousOrderScreen> {

  List<OrderHistoryData> orderHistoryModelObjectPrevious = [];
  bool mainLoader = true;
  int orderStatus = 1;

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
    print("orderHistoryApi: ${orderHistoryApiUrl+userId}");
    print("orderStatus: ${orderStatus.toString()}");
    if(jsonData["message"] == "All Delivered orders"){
      print("All Delivered orders");
      // toastMessage("All Delivered orders", Colors.green);
    }
    if (response.statusCode == 200) {
      for (int i = 0; i < jsonData['data'].length; i++) {
        Map<String, dynamic> obj = jsonData['data'][i];
        var pos = OrderHistoryData();
        pos = OrderHistoryData.fromJson(obj);
        orderHistoryModelObjectPrevious.add(pos);
      }
      print("orderHistoryLength: ${orderHistoryModelObjectPrevious.length}");
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
              orderHistoryModelObjectPrevious.length < 1 ? Center(child: Text("No data ", style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold),)):
              ListView.builder(
                  itemCount: orderHistoryModelObjectPrevious.length,
                  itemBuilder: (context, index){
                    var dateTimeConverted = DateTime.parse(orderHistoryModelObjectPrevious[index].createdAt!);
                    forMateDate = myFormat.format(dateTimeConverted);
                    print('now previousScreen date has been converted ${forMateDate}');

                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => UserFeedbackScreen(
                              productId: orderHistoryModelObjectPrevious[index].checkoutProducts![0].productId,
                            )));
                        print("productIdPrevious: ${orderHistoryModelObjectPrevious[index].checkoutProducts![0].productId}");
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10), color: kWhite),
                        padding: EdgeInsets.all(16),
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(05),
                              child: Image(
                                fit: BoxFit.fill,
                                width: MediaQuery.of(context).size.width * 0.25,
                                height: MediaQuery.of(context).size.height * 0.12,
                                image: NetworkImage(
                                    productBaseUrl + "${orderHistoryModelObjectPrevious[index].checkoutProducts![0].product!.myImages![0]}"),
                              ),
                            ),

                            SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Id: ${orderHistoryModelObjectPrevious[index].checkoutProducts![0].productId}",
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                Text("GrossTotal: ${orderHistoryModelObjectPrevious[index].grossTotal}",
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                Text("Items (${orderHistoryModelObjectPrevious[index].quantity})",
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
