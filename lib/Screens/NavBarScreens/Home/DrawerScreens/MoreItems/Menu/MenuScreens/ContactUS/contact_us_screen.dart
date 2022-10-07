import 'package:crypto_cent/Utils/url.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:open_mail_app/open_mail_app.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  var id;
  var phone;
  var email;
  var location;

  bool loader = true;

  callTermsAndConditionAPi(String token) async {
    http.Response response = await http.get(Uri.parse(contactUrl),
        headers: {'Authorization': 'Bearer $token'});
    print(response.body.toString());
    Map jsonData = jsonDecode(response.body);
    phone = (jsonData['contact']['phone']);
    email = (jsonData['contact']['email']);
    location = (jsonData['contact']['address']);

    setState(() {
      loader = false;
    });
  }

  getSharedPreference() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    id = sharedPreferences.getString('userToken');
    callTermsAndConditionAPi(id);
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
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
      body: loader ? Center(child: CircularProgressIndicator()) :
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
                        },
                      child: Container(
                          height: 30,width: 30,
                          child: const Icon(CupertinoIcons.back))),
                  const Text(
                    'Contact Us',
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const Icon(CupertinoIcons.ellipsis_vertical),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
            Container(
              alignment: Alignment.bottomLeft,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: const Text(
                'Contact Us',
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02,),

            GestureDetector(
              onTap: () {
                _makePhoneCall('tel:$phone');
                },
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade100),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: const Icon(CupertinoIcons.phone, size: 30,),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.04,),
                    Text(phone,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
            GestureDetector(
              onTap: () async {
                EmailContent myEmailContent = EmailContent(
                  to: [email,],
                  subject: 'Hello!',
                  body: 'How are you doing?',
                  // cc: ['user2@domain.com', 'user3@domain.com'],
                  // bcc: ['boss@domain.com'],
                );
                OpenMailAppResult result =
                await OpenMailApp.composeNewEmailInMailApp(
                    nativePickerTitle: 'Select email app to compose',
                    emailContent: myEmailContent);
                if (!result.didOpen && !result.canOpen) {
                  showNoMailAppsDialog(context);
                } else if (!result.didOpen && result.canOpen) {
                  showDialog(
                    context: context,
                    builder: (_) => MailAppPickerDialog(
                      mailApps: result.options,
                      emailContent: myEmailContent,
                    ),
                  );
                }
                },
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade100),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: const Icon(CupertinoIcons.mail, size: 30,),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.04,
                          ),
                          Text(
                            email,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                  GestureDetector(
                    onTap: (){
                      // navigateTo(nearCentre[0].lat.toString(),
                      //     nearCentre[0].lng.toString());
                    },

                    child: Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.shade100),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                            child: const Icon(
                              CupertinoIcons.location,
                              size: 30,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.04,
                          ),
                          Text(
                            location,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    ));
  }

  void showNoMailAppsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Open Mail App"),
          content: Text("No mail apps installed"),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

}
