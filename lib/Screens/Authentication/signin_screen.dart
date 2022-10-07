import 'package:crypto_cent/Models/user_login_model.dart';
import 'package:crypto_cent/Screens/Authentication/GoogleSignIn/provider/wallet_provider.dart';
import 'package:crypto_cent/Utils/url.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Utils/color.dart';
import '../../widgets/toast_message.dart';
import '../NavBarScreens/nav_bar_screen.dart';
import 'ForgetPassword/forget_password.dart';
import 'GoogleSignIn/provider/google_sign_in.dart';
import 'facebook_login_widget.dart';
import 'SignUp/signup_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'login_api.dart';

TextEditingController phoneController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController emailController = TextEditingController();

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool isLogin = false;
  bool loader = false;
  // UserLoginModel? userLoginModelObject;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool loading = false;
  SharedPreferences? prefs;

  getLogin() async {
    setState(() {
      isLogin = true;
    });
    bool temp = await SignInApi()
        .signin(email: emailController.text, password: passwordController.text);
    if (temp) {
      WalletProvider walletPro =
          Provider.of<WalletProvider>(context, listen: false);
      String uid = SignInApi.uid;
      bool tempbol = await walletPro.dataLoad(uid);
    }
    print(phoneController.text);
    print(passwordController.text);
    Map body = {
      'phone': phoneController.text.toString(),
      'password': passwordController.text,
    };
    http.Response response = await http.post(Uri.parse(loginUrl), body: body);
    print('response==' + response.body.toString());
    Map jsonData = jsonDecode(response.body);
    if (jsonData['status'] == "success") {
      userId = (jsonData['user']['id']);
      userToken = (jsonData['token']);
      print("userId $userId");
      print("userToken $userToken");
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('userId', userId.toString());
      sharedPreferences.setString('userToken', userToken);
      sharedPreferences.setString('userPassword', passwordController.text);
      print("userId ${userId.toString()}");
      print("userToken $userToken");
      print("userPassword ${passwordController.text}");
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const NavBarScreen()));
      toastMessage('Login Successfully', Colors.green);
    } else {
      setState(() {
        toastMessage('Incorrect number or password', Colors.red);
        print(
          'Incorrect number or password',
        );
        isLogin = false;
      });
    }
    setState(() {
      isLogin = false;
    });
  }

  UserLoginModel? userObject;

  sharedPrefs() async {
    loading = true;
    setState(() {});
    print('in LoginPage shared prefs');
    prefs = await SharedPreferences.getInstance();
    userToken = (prefs!.getString('userToken'));
    userId = prefs!.getString('userId');
    print("userId in LoginPrefs is = $userId");
    print("token in LoginPrefs is = $userToken");
    if (userToken != null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => NavBarScreen()));
    } else {
      loading = false;
      setState(() {});
      print("token value is = $userToken");
    }
  }

  @override
  void initState() {
    super.initState();
    sharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Image(
                image: AssetImage('assets/images/wel.jpg'),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              const Text(
                'Welcome',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
              ),
              buildLoginTextFields(),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ForgetPassword()));
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 20, right: 10),
                  width: MediaQuery.of(context).size.width,
                  child: const Text(
                    'Forget Password?',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              GestureDetector(
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    await getLogin();
                  }

                  // if (phoneController.text.length == 0) {
                  //   toastMessage('phone number cannot be empty', Colors.red);
                  // } else if (phoneController.text.length < 7) {
                  //   toastMessage('phone number must be 7 digit', Colors.red);
                  // } else if (passwordController.text.length == 0) {
                  //   toastMessage('password cannot be empty', Colors.red);
                  // } else if (passwordController.text.length < 5) {
                  //   toastMessage('password must be 6 digit', Colors.red);
                  // } else {
                  //   getLogin();
                  // }
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
                  child: isLogin == true
                      ? Center(child: CircularProgressIndicator())
                      : Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
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
                        print("signIn with googleClicked");
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
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpScreen()));
                },
                child: Container(
                    margin: const EdgeInsets.only(left: 20, right: 10),
                    width: MediaQuery.of(context).size.width,
                    child: RichText(
                      text: TextSpan(
                        text: 'Not a member? ',
                        style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                        children: [
                          TextSpan(
                              text: 'Join Now',
                              onEnter: (event) {},
                              style: TextStyle(
                                  color: primarycolor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                    )),
              ),
              const SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLoginTextFields() {
    return Column(
      children: [
        Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                margin: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(40)),
                child: TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Phone Number',
                      labelText: 'Phone Number',
                      prefixIcon: Icon(
                        Icons.phone,
                      )),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Phone number cannot be empty";
                    } else if (value.length < 7) {
                      return "phone number must be 7 digit";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                margin: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(40)),
                child: TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'email',
                      labelText: 'email',
                      prefixIcon: Icon(Icons.email)),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "email cannot be empty";
                    }

                    return null;
                  },
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                margin: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(40)),
                child: TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Password',
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock)),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "password cannot be empty";
                    } else if (value.length < 5) {
                      return "password must be of 6 digit";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
