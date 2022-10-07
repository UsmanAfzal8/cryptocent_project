import 'dart:convert';
import 'package:crypto_cent/Utils/color.dart';
import 'package:crypto_cent/Utils/url.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TermsAndConditionScreen extends StatefulWidget {
  const TermsAndConditionScreen({Key? key}) : super(key: key);

  @override
  State<TermsAndConditionScreen> createState() =>
      _TermsAndConditionScreenState();
}

class _TermsAndConditionScreenState extends State<TermsAndConditionScreen> {
  var userToken;
  var title;
  var description;
  bool loader = true;

  callTermsAndConditionsAPi(String token) async {
    http.Response response = await http.get(Uri.parse(termsAndConditionsUrl),
        headers: {'Authorization': 'Bearer $token'});
    print(response.body.toString());
    Map jsonData = jsonDecode(response.body);
    title = (jsonData['view']['title']);
    description = (jsonData['view']['description']);
    setState(() {
      loader = false;
    });
  }

  getSharedPreference() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userToken = sharedPreferences.getString('userToken');
    callTermsAndConditionsAPi(userToken);
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
          body: loader ? Center(
            child: CircularProgressIndicator(),
          ) :
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            //  Scaffold.of(context).openDrawer();
                          },
                          child: Container(
                            height: 30,width: 30,
                              child: const Icon(CupertinoIcons.back))),
                      const Text('Terms and Condition',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                      const Icon(CupertinoIcons.ellipsis_vertical),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
                Container(
                  alignment: Alignment.bottomLeft,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: Text(title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  width: MediaQuery.of(context).size.width,
                  child: Text(description, style: TextStyle(fontSize: 16),),
                ),
              ],
            ),
          ),
        ));
  }
}
