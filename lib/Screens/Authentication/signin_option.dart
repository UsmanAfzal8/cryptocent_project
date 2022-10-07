import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Utils/color.dart';
import 'GoogleSignIn/pages/home_page_signin.dart';
import 'GoogleSignIn/provider/google_sign_in.dart';
import 'facebook_login_widget.dart';

class SignInOptionScreen extends StatefulWidget {
  const SignInOptionScreen({Key? key}) : super(key: key);

  @override
  State<SignInOptionScreen> createState() => _SignInOptionScreenState();
}

class _SignInOptionScreenState extends State<SignInOptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              const Image(
                image: AssetImage('assets/images/wel.jpg'),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePageSignIn()));
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 20),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: primarycolor),
                  child: const Text(
                    'Login with Email',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              const Text(
                'or',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        signInWithFacebook();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        width: MediaQuery.of(context).size.width / 3.8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.grey.shade200),
                        child: Image(
                          height: MediaQuery.of(context).size.height * 0.03,
                          image: const AssetImage('assets/images/fb.jpg'),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        print("clicked");
                        final provider = Provider.of<GoogleSingInProvider>(
                            context,
                            listen: false);
                        provider.googleLogin();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        width: MediaQuery.of(context).size.width / 3.8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.grey.shade200),
                        child: Image(
                          height: MediaQuery.of(context).size.height * 0.03,
                          image: const AssetImage('assets/images/google.png'),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width / 3.8,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.grey.shade200),
                      child: Image(
                        height: MediaQuery.of(context).size.height * 0.03,
                        image: const AssetImage('assets/images/apple.png'),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
