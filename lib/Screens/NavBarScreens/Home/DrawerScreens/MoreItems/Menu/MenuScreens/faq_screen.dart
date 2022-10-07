import 'package:crypto_cent/Models/faq_model.dart';
import 'package:crypto_cent/Utils/url.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FaqScreen extends StatefulWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  var userToken;
  var title;
  var description;
  bool loader = true;
  List<FaqsModel> _faqList = [];

  callFAQsApi(String token) async {
    http.Response response = await http
        .get(Uri.parse(faqUrl), headers: {'Authorization': 'Bearer $token'});
    print(response.body.toString());
    Map jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      for (int i = 0; i < jsonData['faqs'].length; i++) {
        Map<String, dynamic> obj = jsonData['faqs'][i];

        var pos = FaqsModel();
        pos = FaqsModel.fromJson(obj);
        _faqList.add(pos);
      }
      setState(() {
        loader = false;
      });
    }

    // title = (jsonData['view']['title']);
    // description = (jsonData['view']['description']);
    setState(() {
      loader = false;
    });
  }

  getSharedPreference() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userToken = sharedPreferences.getString('userToken');
    callFAQsApi(userToken);
  }

  @override
  void initState() {
    super.initState();
    getSharedPreference();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loader ? Center(
        child: CircularProgressIndicator(),
      ) :
      SingleChildScrollView(
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
                        },
                      child: Container(
                          height: 30,width: 30,
                          child: const Icon(CupertinoIcons.back))),
                  const Text('FAQs', style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const Icon(CupertinoIcons.ellipsis_vertical),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            ListView.builder(
                itemCount: _faqList.length,
                shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.bottomLeft,
                      width: MediaQuery.of(context).size.width * 0.9,
                      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Text(
                        "Q: ${_faqList[index].faqsTitle.toString()}",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        maxLines: 2,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        "Ans: ${_faqList[index].faqsAnswer.toString()}",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              );
            }),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
      ],
    ),
      ),
    );
  }
}
