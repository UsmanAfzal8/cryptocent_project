import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../Utils/url.dart';
import '../../../../widgets/toast_message.dart';
import '../../../NavBarScreens/nav_bar_screen.dart';
import '../../SignUp/signup_screen.dart';
import 'package:http/http.dart' as http;

class GoogleSingInProvider extends ChangeNotifier{

  final googleSingIn = GoogleSignIn();
  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

   googleLogin() async {
    print("in google login");
    try{
      final googleUser = await googleSingIn.signIn();
      if(googleUser == null) {
        return ;
      }
      _user = googleUser;
      getLogin();
      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken);
      await FirebaseAuth.instance.signInWithCredential(credential);
      print("credentials $credential");


    }
    catch (e){
      print(e.toString());
    }
    notifyListeners();
  }

  Future logOut() async {
    //await googleSingIn.disconnect();
    FirebaseAuth.instance.signOut();
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
      Get.to(NavBarScreen());
    if (jsonData['message'] == "account banned or email or password are incorrect") {
      toastMessage('Incorrect number or password', Colors.red);

      // setState(() {
        isLogin = false;
      // });
    }
    // setState(() {
      isLogin = false;
    // });
  }
}