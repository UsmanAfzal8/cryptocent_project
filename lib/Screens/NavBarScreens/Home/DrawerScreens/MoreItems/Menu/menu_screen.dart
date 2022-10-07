import 'package:crypto_cent/Utils/color.dart';
import 'package:crypto_cent/Utils/url.dart';
import 'package:crypto_cent/widgets/toast_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../Authentication/GoogleSignIn/provider/google_sign_in.dart';
import '../../../../../SplashScreen/welcome_screen.dart';
import 'MenuScreens/ContactUS/contact_us_screen.dart';
import 'MenuScreens/about_us_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'MenuScreens/faq_screen.dart';
import 'MenuScreens/privacy_policy.dart';
import 'MenuScreens/terms_and_conditions.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  var id;
  var title;
  var description;
  bool loader = true;

  callLogoutAPi() async {
    http.Response response = await http
        .post(Uri.parse(logout), headers: {'Authorization': 'Bearer $id'});
    print(response.body.toString());
    Map jsonData = jsonDecode(response.body);
    if (jsonData['message'] == 'Logged out') {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.clear();
      final provider = Provider.of<GoogleSingInProvider>(context, listen: false);
      provider.logOut();
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => WelcomeScreen()),
          (route) => false);
    }
    setState(() {
      loader = false;
    });
  }

  getSharedPreference() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    id = sharedPreferences.getString('userToken');
    setState(() {
      loader = false;
    });
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
            title: Text("Menu", style: TextStyle(color: kBlack),),
            centerTitle: true,
            backgroundColor: kWhite,
            iconTheme: IconThemeData(color: kBlack),
            automaticallyImplyLeading: false,
            elevation: 2,
            leading:  GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                    height: 20, width: 20, color: Colors.transparent,
                    child: const Icon(CupertinoIcons.back))),
          ),
      body: loader ? Center(child: CircularProgressIndicator()) :
      SingleChildScrollView(
        child: Column(
          children: [

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AboutUSScreen()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.grey.shade100,
                      ),
                      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('About Us',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          Icon(CupertinoIcons.forward)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                              builder: (context) => FaqScreen()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.grey.shade100,
                      ),
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('FAQs',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                          Icon(CupertinoIcons.forward)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                              builder: (context) => TermsAndConditionScreen()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.grey.shade100,
                      ),
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Terms & Conditions',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                          Icon(CupertinoIcons.forward)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PrivacyPolicyScreen()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.grey.shade100,
                      ),
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Privacy Policy',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                          Icon(CupertinoIcons.forward)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ContactUsScreen()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.grey.shade100,
                      ),
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Contact Us',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                          Icon(CupertinoIcons.forward)
                        ],
                      ),
                    ),
                  ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
            GestureDetector(
              onTap: () {
                callLogoutAPi().then((value){
                  toastMessage("LogOut Successfully...!", Colors.green);
                });
                },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.grey.shade100,
                ),
                margin: const EdgeInsets.only(left: 20, right: 20),
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Logout',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                    Icon(CupertinoIcons.forward)
                  ],
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
          ],
        ),
      ),
    ));
  }
}
