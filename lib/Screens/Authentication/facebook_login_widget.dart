import 'dart:convert';
import 'package:crypto_cent/widgets/toast_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/url.dart';
import '../NavBarScreens/nav_bar_screen.dart';
import 'SignUp/signup_screen.dart';

void signInWithFacebook() async {
  try {
    final LoginResult result = await FacebookAuth.instance.login(
        permissions: (['email', 'public_profile']));
    final token = result.accessToken!.token;
    print('Facebook token userID : ${result.accessToken!.grantedPermissions}');
    final graphResponse = await http.get(
        Uri.parse('https://graph.facebook.com/'
            'v2.12/me?fields=name,first_name,last_name,email&access_token=${token}'));

    final profile = jsonDecode(graphResponse.body);
    print("Profile is equal to $profile");
    getLogin();
    try {
      final AuthCredential facebookCredential = FacebookAuthProvider.credential(result.accessToken!.token);
      final userCredential = await FirebaseAuth.instance.signInWithCredential(facebookCredential);
      print("userCredentialsFacebook: $userCredential");
      Get.to(NavBarScreen());
    } catch (e) {
      // toastMessage("toastMessage", Colors.red);
      print("error in catch ${e.toString()}");
      // final snackBar = SnackBar(
      //   margin: const EdgeInsets.all(20),
      //   behavior: SnackBarBehavior.floating,
      //   content: Text(e.toString()),
      //   backgroundColor: (Colors.redAccent),
      //   action: SnackBarAction(
      //     label: 'dismiss',
      //     onPressed: () {},
      //   ),
      // );
      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  } catch (e) {
    print("error occurred: ${e.toString()}");
    // print(e.toString());
  }
}

bool isLogin = false;
getLogin() async {
  // setState(() {
  isLogin = true;
  // });
  Map body = {
    'phone': "123456789",
    'password': "1234567",
  };
  http.Response response = await http.post(Uri.parse(loginUrl),
      body: body
  );
  print('response==' + response.body.toString());
  Map jsonData = jsonDecode(response.body);
  userId = (jsonData['user']['id']);

  print(userId);
  print("loginApiUrl: $loginUrl");
  userToken = (jsonData['token']);
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString('userId', userId.toString());
  sharedPreferences.setString('userToken', userToken);
  sharedPreferences.setString('userPassword', "1234567");
  print("userId ${userId.toString()}");
  print("userToken $userToken");
  print("userPassword 1234567");
  Get.to(()=> NavBarScreen());
  // setState(() {
  isLogin = false;
  // });
}