import 'package:crypto_cent/Models/add_follower_model.dart';
import 'package:crypto_cent/Models/show_all_user_model.dart';
import 'package:crypto_cent/Utils/color.dart';
import 'package:crypto_cent/Utils/url.dart';
import 'package:crypto_cent/widgets/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisteredUsersScreen extends StatefulWidget {
  const RegisteredUsersScreen({Key? key}) : super(key: key);

  @override
  _RegisteredUsersScreenState createState() => _RegisteredUsersScreenState();
}

class _RegisteredUsersScreenState extends State<RegisteredUsersScreen> {
  List<ShowAllUsersDataModel>? _showAllUser = [];
  List<AddFollower>? showAddFollowers = [];
  var pageNumber = 1;
  var userToken;
  var userId;
  var followedId;
  bool isLoadAllProduct = false;
  final ScrollController _scrollController = new ScrollController();

  getSharedPreference() async {
    setState(() {
      isLoadAllProduct = true;
    });
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userToken = sharedPreferences.getString('userToken');
    userId = sharedPreferences.getString('userId');
    print("userId in sharedPrefs: $userId");
    print("userToken in sharedPrefs: $userToken");

    callAllUserApi();
  }

  callAllUserApi() async {
    Map body = {
      'page': pageNumber.toString(),
    };
    http.Response response =
        await http.post(Uri.parse(showAllUserUrl),
            body: body,
            headers: {
          'Authorization': 'Bearer $userToken',
          "Accept": "application/json"
    });
    Map jsonData = jsonDecode(response.body);
    print('allUserApiResponse==' + jsonData.toString());
    if (response.statusCode == 200) {
      for (int i = 0; i < jsonData['user']['data'].length; i++) {
        Map<String, dynamic> obj = jsonData['user']['data'][i];
        print(obj['id']);
        var pos = ShowAllUsersDataModel();
        pos = ShowAllUsersDataModel.fromJson(obj);
        _showAllUser!.add(pos);
        print("showAllUserLength: ${_showAllUser!.length}");
        setState(() {
          isLoadAllProduct = false;
        });
      }
    }
  }

  addFollowerApi(String id) async {
    print("userToken: $userToken");
    print("userId123: $userId");
    print("followedId: $id");
    http.Response response = await http.post(Uri.parse(addFollowersUrl),
        body: {
          "follower_id": userId,
          "followed_id": id,
        },
        headers: {
      "Authorization": "Bearer $userToken",
      "Accept": "application/json",
    });
    print("addFollowerApi: $addFollowersUrl");
    Map jsonData = jsonDecode(response.body);
    print('jsonResponse: ' + jsonData.toString());
    // if (response.statusCode == 200) {
      // toastMessage("Now you are become friend!");

      // print("print: ${_showAddFollowers![0].message}");

      // for (int i = 0; i < jsonData["data"].length; i++) {
      //   Map<String, dynamic> obj = jsonData["data"][i];
      //   print(obj['id']);
      //   var pos = AddFollowerData();
      //   pos = AddFollowerData.fromJson(obj);
      //   _showAddFollowers!.add(pos);
      //   print("showAddFollowerLength: ${_showAddFollowers!.length}");
      //   print("followerId: $userId");
      //   setState(() {
      //     isLoadAllProduct = false;
      //   });
      // }

    // }
  }

  @override
  void initState() {
    super.initState();
    getSharedPreference();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        pageNumber++;
        // checkConnectivity();
        setState(() {
          isLoadAllProduct = true;
        });
        getSharedPreference();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoadAllProduct == true ? Center(
        child: CircularProgressIndicator(),
      ) :
      SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.85,
              child: ListView.builder(
                  // physics: BouncingScrollPhysics(),
                  itemCount: _showAllUser!.length,
                  itemBuilder: (context, index) {
                    followedId = _showAllUser![index].id.toString();
                    print("showAllUserIds $followedId");
                    return GestureDetector(
                      onTap: (){
                        print("clickId123: ${followedId = _showAllUser![index].id}");
                        },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 05, vertical: 05),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(_showAllUser![index].name.toString(),
                                    style: TextStyle(fontSize: 16),
                                  )
                                ],
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await addFollowerApi(_showAllUser![index].id.toString());
                                  toastMessage("Now you are become friend!", Colors.green);
                                  setState(() {
                                    _showAllUser!.removeAt(index);
                                  });
                                  },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: primarycolor),
                                  child: Text('Follow',
                                    style: TextStyle(color: kWhite, fontSize: 12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
          ],
        ),
      ),
    );
  }
}
