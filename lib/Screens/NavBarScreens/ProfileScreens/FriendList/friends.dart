import 'dart:convert';
import 'package:crypto_cent/Models/show_following_model.dart';
import 'package:crypto_cent/Utils/color.dart';
import 'package:crypto_cent/Utils/url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Messages/show_messages.dart';

class FriendScreen extends StatefulWidget {
  const FriendScreen({Key? key}) : super(key: key);

  @override
  _FriendScreenState createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendScreen> {
  List<ShowFollowingData>? showFollowingObject = [];
  var userToken;
  var userId;
  var pageNumber = 1;

  @override
  void initState() {
    super.initState();
    getSharedPreference();
  }

  getSharedPreference() async {
    setState(() {
      isLoadAllProduct = true;
    });
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userToken = sharedPreferences.getString('userToken');
    userId = sharedPreferences.getString('userId');
    print("userId: $userId");
    print("userToken: $userToken");
    callAllUserApi(userToken);
  }

  callAllUserApi(String token) async {
    Map body = {
      'page': pageNumber.toString(),
    };
    http.Response response =
    await http.post(Uri.parse(showFollowingUrl+userId),
        body: body,
        headers: {
      'Authorization': 'Bearer $token',
      // "Accept": "application/json"
    });
    // print("showFollowingApiUrl: ${showFollowingUrl+ userId}");
    print("showFollowingBody: ${body}");
    print("showFollowingApiUrl: ${showFollowingUrl+userId}");
    Map jsonData = jsonDecode(response.body);
    print('hello==' + jsonData.toString());

    if (jsonData['message'] == 'Record Not Found') {
      print('Record Not Found');
      setState(() {
        isLoadAllProduct = false;
      });
    } else if (response.statusCode == 200) {
      for (int i = 0; i < jsonData['show']['data'].length; i++) {
        Map<String, dynamic> obj = jsonData['show']['data'][i];
        print("ObjectId: ${obj['id']}");
        var pos = ShowFollowingData();
        pos = ShowFollowingData.fromJson(obj);
        showFollowingObject!.add(pos);
        print("showFollowingObject: ${showFollowingObject!.length}");
        setState(() {
          isLoadAllProduct = false;
        });
      }
    }
  }
  bool isLoadAllProduct = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoadAllProduct ? Center(
          child: CircularProgressIndicator()) :
      showFollowingObject!.isEmpty ? Center(child: Text("No following found")):

      SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: showFollowingObject!.length,
                  itemBuilder: (BuildContext context, int index){
                    print("followerName: ${showFollowingObject![0].followed!.name}");
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            // height: MediaQuery.of(context).size.height,
                            margin: const EdgeInsets.symmetric(horizontal: 05, vertical: 05),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [

                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.35,
                                      color: Colors.transparent,
                                      child: Text("${showFollowingObject![index].followed!.name}",
                                      // child: Text("dnhdghdhdhacd  dhd uidhdhuhduhduhduao hudahud",
                                      maxLines: 2, overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 16),),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(
                                                builder: (context) => ShowMessages(
                                                  name: showFollowingObject![index].followed!.name
                                                )));
                                      },
                                      child: Container(
                                        padding:
                                        EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: primarycolor),
                                        child: Text('Message', style: TextStyle(color: kWhite, fontSize: 12),),
                                      ),
                                    ),
                                    SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                      decoration: BoxDecoration(
                                          border: Border.all(color: primarycolor),
                                          borderRadius: BorderRadius.circular(20),
                                          color: kWhite),
                                      child: Text('Send Crypto',
                                        style: TextStyle(color: primarycolor, fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        elevation: 2,
                      ),
                    );
                  }),
            ),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Row(
            //       children: [
            //         Stack(
            //           children: [
            //             Container(
            //               margin: const EdgeInsets.all(10),
            //               child:  CircleAvatar(
            //                 radius: 30,
            //                 backgroundImage:
            //                     AssetImage('assets/images/welcome.jpg'),
            //               ),
            //             ),
            //             Container(
            //               decoration: BoxDecoration(
            //                   borderRadius: BorderRadius.circular(30),
            //                   color: Colors.grey.shade300),
            //               margin: EdgeInsets.only(
            //                   top: MediaQuery.of(context).size.height * 0.06,
            //                   left: MediaQuery.of(context).size.width * 0.14),
            //               child: const Icon(
            //                 Icons.remove,
            //                 color: Colors.red,
            //               ),
            //             )
            //           ],
            //         ),
            //         Column(
            //           children: const [
            //             Text(
            //               'Ahmed',
            //               style: TextStyle(fontSize: 20),
            //             ),
            //             // Text(
            //             //   'Retailer',
            //             //   style: TextStyle(fontSize: 18),
            //             // ),
            //           ],
            //         )
            //       ],
            //     ),
            //     Container(
            //       padding: const EdgeInsets.all(10),
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(4),
            //         color: primarycolor,
            //       ),
            //       margin: const EdgeInsets.only(right: 20),
            //       child: const Text(
            //         'Send crypto',
            //         style: TextStyle(color: Colors.white, fontSize: 16),
            //       ),
            //     ),
            //   ],
            // ),
            // Container(
            //     margin: const EdgeInsets.only(left: 10, right: 10),
            //     child: const Divider()),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Row(
            //       children: [
            //         Stack(
            //           children: [
            //             Container(
            //               margin: const EdgeInsets.all(10),
            //               child: const CircleAvatar(
            //                 radius: 30,
            //                 backgroundImage:
            //                     AssetImage('assets/images/welcome.jpg'),
            //               ),
            //             ),
            //             Container(
            //               decoration: BoxDecoration(
            //                   borderRadius: BorderRadius.circular(30),
            //                   color: Colors.grey.shade300),
            //               margin: EdgeInsets.only(
            //                   top: MediaQuery.of(context).size.height * 0.06,
            //                   left: MediaQuery.of(context).size.width * 0.14),
            //               child: const Icon(
            //                 Icons.remove,
            //                 color: Colors.red,
            //               ),
            //             )
            //           ],
            //         ),
            //         Column(
            //           children: const [
            //             Text(
            //               'Ahmed',
            //               style: TextStyle(fontSize: 20),
            //             ),
            //             // Text(
            //             //   'Retailer',
            //             //   style: TextStyle(fontSize: 18),
            //             // ),
            //           ],
            //         )
            //       ],
            //     ),
            //     Container(
            //       padding: const EdgeInsets.all(10),
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(4),
            //         color: primarycolor,
            //       ),
            //       margin: const EdgeInsets.only(right: 20),
            //       child: const Text(
            //         'Send crypto',
            //         style: TextStyle(color: Colors.white, fontSize: 16),
            //       ),
            //     ),
            //   ],
            // ),
            // Container(
            //     margin: const EdgeInsets.only(left: 10, right: 10),
            //     child: const Divider()),
          ],
        ),
      ),
    );
  }

  Widget getUser(String image, String name, String country) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => ProfileScreen()));
      },
      child: Slidable(
        endActionPane: const ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              flex: 1,
              onPressed: null,
              backgroundColor: Colors.white,
              foregroundColor: Colors.red,
              label: 'Remove',
            ),
          ],
        ),
        child: Container(
          // height: MediaQuery.of(context).size.height,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image(
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                        image: AssetImage(image)),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                  Text(
                    name,
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(
                      //         builder: (context) => ShowMessages()));
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: primarycolor),
                      child: Text(
                        'Message',
                        style: TextStyle(color: kWhite, fontSize: 12),
                      ),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                        border: Border.all(color: primarycolor),
                        borderRadius: BorderRadius.circular(20),
                        color: kWhite),
                    child: Text(
                      'Send Crypto',
                      style: TextStyle(color: primarycolor, fontSize: 12),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
