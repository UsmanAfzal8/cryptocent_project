import 'dart:convert';
import 'package:crypto_cent/Models/notification_model.dart';
import 'package:crypto_cent/Utils/color.dart';
import 'package:crypto_cent/Utils/url.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../../Authentication/SignUp/signup_screen.dart';
import '../../../ProfileScreens/OrderHistory/order_history_screen.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
List<NotificationData> notificationModelObject = [] ;
bool loading = false;

getSharedPreference() async {
  setState(() {
    loading = true;
  });
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  userToken = sharedPreferences.getString('userToken');
  userId = sharedPreferences.getString('userId');

  print('token==$userToken');
  print('id==$userId');

  notificationApi(userToken);
}

notificationApi(String token) async {
  setState(() {
    loading = true;
  });
  http.Response response = await http.get(Uri.parse(notificationApiUrl),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept' : 'application/json'
      });
  Map jsonData = jsonDecode(response.body);
  print("notificationApi: ${notificationApiUrl}");
  print("statusCode: ${response.statusCode}");
  print("userToken: $token");
  if (response.statusCode == 200) {
    for (int i = 0; i < jsonData['data'].length; i++) {
      Map<String, dynamic> obj = jsonData['data'][i];
      var pos = NotificationData();
      pos = NotificationData.fromJson(obj);
      notificationModelObject.add(pos);
      print("notificationLength: ${notificationModelObject.length}");
      print("notificationImage: ${notificationImageBaseUrl + notificationModelObject[0].image.toString()}");
    }
    print("notificationLength: ${notificationModelObject.length}");

    setState(() {
      loading = false;
    });
  }
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
            title: Text('Notification',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
            ),
            centerTitle: true,
            iconTheme: IconThemeData(color: kBlack),
            backgroundColor: kWhite,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          backgroundColor: kWhite,
          body: loading? Center(child: CircularProgressIndicator()):
          notificationModelObject.length < 1 ? Center(child: Text("No new Notification",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)):
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                      itemCount: notificationModelObject.length,
                      itemBuilder: (context, index) {
                        var dateTimeConverted = DateTime.parse(notificationModelObject[index].createdAt!);
                        forMateDate = myFormat.format(dateTimeConverted);
                        print('now date has been converted ${forMateDate}');

              return Card(
                margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(05),
                        child: FadeInImage(
                          placeholder: AssetImage("assets/icons/fade_in_image.jpeg"),
                          fit: BoxFit.fill,
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.height * 0.12,
                          image: NetworkImage(
                              notificationImageBaseUrl + "${notificationModelObject[index].image}"),
                        ),
                      ),

                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width /1.8,
                            child: Text("${notificationModelObject[index].title.toString()}",
                              maxLines: 2, overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,),
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                          Container(
                            width: MediaQuery.of(context).size.width /1.8,
                            child: Text("${notificationModelObject[index].description.toString()}",
                              maxLines: 1, overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                          Text(forMateDate.toString(),
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                        ]),
                      ]),
                    ));
                  }),
                ),
              ]),
            ),
        ));
      }
}
