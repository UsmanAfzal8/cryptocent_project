import 'package:crypto_cent/Utils/color.dart';
import 'package:crypto_cent/Utils/url.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AboutUSScreen extends StatefulWidget {
  const AboutUSScreen({Key? key}) : super(key: key);

  @override
  State<AboutUSScreen> createState() => _AboutUSScreenState();
}

class _AboutUSScreenState extends State<AboutUSScreen> {
  var id;
  var title;
  var description;
  bool loader = true;

  callAboutUsApi(String token) async {
    http.Response response = await http.get(Uri.parse(aboutUsUrl),
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
    callAboutUsApi(id);
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
                    const Text('About Us',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                    const Icon(CupertinoIcons.ellipsis_vertical),
                  ],
                ),
              ),

              Container(
                alignment: Alignment.bottomLeft,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
                child: Text(title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),

              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                width: MediaQuery.of(context).size.width,
                child: Text(description,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
