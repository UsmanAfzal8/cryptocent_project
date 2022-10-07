import 'package:crypto_cent/Utils/url.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  var id;
  var title;
  var description;
  bool loader = true;

  callTermsAndConditionsAPi(String token) async {
    http.Response response = await http.get(Uri.parse(privacyPolicyUrl),
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
    id = sharedPreferences.getString('userToken');
    callTermsAndConditionsAPi(id);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPreference();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loader
      ? Center(
          child: CircularProgressIndicator(),
        )
      : SingleChildScrollView(
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
                          //  Scaffold.of(context).openDrawer();
                        },
                        child: Container(
                            height: 30,width: 30,
                            child: const Icon(CupertinoIcons.back))),
                    const Text('Privacy Policy',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                    const Icon(CupertinoIcons.ellipsis_vertical),
                  ],
                ),
              ),
              // SizedBox(height: MediaQuery.of(context).size.height * 0.04,),

              // Container(
              //   alignment: Alignment.bottomLeft,
              //   width: MediaQuery.of(context).size.width,
              //   margin: const EdgeInsets.only(left: 20, right: 20),
              //   child: Text(
              //     title,
              //     style: TextStyle(fontSize: 18),
              //   ),
              // ),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.02,
              // ),

              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  description,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
