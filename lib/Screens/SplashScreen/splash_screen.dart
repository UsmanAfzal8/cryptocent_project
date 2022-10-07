import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../NavBarScreens/nav_bar_screen.dart';
import 'welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var id;

  navigate() {
    Timer(const Duration(seconds: 6), () {
      id == null
          ? Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const WelcomeScreen()))
          : Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const NavBarScreen()));
    });
  }

  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    id = sharedPreferences.getString('userId');
    print('idd=$id');
    navigate();
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/video/v5.json',
      width: 200,
      height: 200,
      fit: BoxFit.fill,
    );
  }
}
