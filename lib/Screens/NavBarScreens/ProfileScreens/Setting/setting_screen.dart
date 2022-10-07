import 'dart:convert';
import 'package:crypto_cent/Utils/color.dart';
import 'package:crypto_cent/Utils/url.dart';
import 'package:crypto_cent/widgets/toast_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Authentication/ForgetPassword/change_password.dart';
import '../../../Authentication/SignUp/signup_screen.dart';
import '../../../SplashScreen/welcome_screen.dart';
import 'change_phone_number.dart';
import '../DeliveryAddress/edit_profile.dart';
import 'package:http/http.dart' as http;
import '../DeliveryAddress/show_all_addresses.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  GlobalKey<FormState> formKeyDeActivateAccount = GlobalKey<FormState>();
  SharedPreferences? sharedPreferences;
  getSharedPreference() async {
    setState(() {
      loading = true;
    });
     sharedPreferences = await SharedPreferences.getInstance();
    userToken = sharedPreferences!.getString('userToken');
    userId = sharedPreferences!.getString('userId');
    print('userToken: $userToken');
    print('userID: $userId');
    setState(() {
      loading = true;
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
          title: Text("Settings", style: TextStyle(color: kBlack),),
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
        body: SingleChildScrollView(
          child: Column(
            children: [

              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const ChangePasswordScreen()));
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
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.04,
                          ),
                          const Text(
                            'Change Password',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const Icon(CupertinoIcons.forward)
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
                          builder: (context) => const ChangePhoneScreen()));
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
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.04,
                          ),
                          const Text(
                            'Change Phone number',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const Icon(CupertinoIcons.forward)
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
                          builder: (context) => const ShowAllAddress()));
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
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.04,
                          ),
                          const Text(
                            'Edit Address',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const Icon(CupertinoIcons.forward)
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
                          builder: (context) => const EditProfileScreen()));
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
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.04,
                          ),
                          const Text(
                            'Profile Setting',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const Icon(CupertinoIcons.forward)
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              GestureDetector(
                onTap: () async {
                  await deActivateUserAccount();
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
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.04,
                          ),
                          const Text(
                            'Deactivate Account',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const Icon(CupertinoIcons.forward)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool loading = false;
  deActivateUserAccount() async {
    setState(() {
      loading = true;
    });

    http.Response response = await http.post(Uri.parse(userDeActivateApiUrl + userId),
        headers: {
          'Authorization': 'Bearer $userToken',
    }
    );
    print('userDeActivateApiUrl' + userDeActivateApiUrl + userId);
    print('response==' + response.body.toString());
    var jsonData = jsonDecode(response.body);

    if(jsonData["status"] == "success"){
      sharedPreferences!.clear();
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const WelcomeScreen()));
      toastMessage("Account Deactivated Successfully...", Colors.green);
    }
    setState(() {
      loading = false;
    });
  }

}
