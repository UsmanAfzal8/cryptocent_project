import 'package:crypto_cent/Screens/Authentication/GoogleSignIn/provider/wallet_provider.dart';
import 'package:crypto_cent/Utils/url.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../../../Models/MessagesModels/coinswallet.dart';
import '../../../Models/MessagesModels/wallets.dart';
import '../../../Models/wallet.dart';
import '../../../Models/wallet_api.dart';
import '../../../Utils/color.dart';
import '../../../widgets/toast_message.dart';
import '../../NavBarScreens/nav_bar_screen.dart';
import '../signin_option.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'authapi.dart';

var userId;
var userToken;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  final String uuid = const Uuid().v4();
  bool isSignUp = false;
  static String Walletsid = '';
  getSignup() async {
    setState(() {
      isSignUp = true;
    });
    WalletProvider walletPro =
        Provider.of<WalletProvider>(context, listen: false);
    var user = await AuthApi().signupUser(
        email: emailController.text, password: passwordController.text);
    if (user != null) {
      List<CoinsWallet> coinsWallet = await WallletWithApi().createWallet();
      final Wallets wallets = Wallets(
        seedid: '123',
        uid: AuthApi.uid!,
        coinsWallet: coinsWallet,
        walletId: uuid,
      );
      print('chal para ha');
      print(AuthApi.uid);
      Walletsid = coinsWallet[0].address;
      print(coinsWallet[0].address);
      bool temp1 = await WalletsApi().add(wallets);
      if (temp1) {
        walletPro.load(wallets);
        walletPro.walletAddress(coinsWallet[0].address,
            coinsWallet[0].transferKey, coinsWallet[0].wallet);
      }
    }
    Map body = {
      'name': nameController.text,
      'phone': phoneController.text.toString(),
      'password': passwordController.text,
    };
    http.Response response = await http.post(Uri.parse(signUpUrl),
        body: body, headers: {'Accept': 'application/json'});
    print('response==' + response.body.toString());
    var jsonData = jsonDecode(response.body);
    userId = (jsonData['user']['id']);

    print("userId $userId");
    print("signUpApiUrl: $signUpUrl");
    userToken = (jsonData['token']);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('userId', userId.toString());
    sharedPreferences.setString('userToken', userToken);
    sharedPreferences.setString('userPassword', passwordController.text);
    print("userId ${userId.toString()}");
    print("userToken $userToken");
    print("userPassword ${passwordController.text}");

    if (jsonData["status"] == "success") {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const NavBarScreen()));
      toastMessage("SignUp Successfully...", Colors.green);
    }
    setState(() {
      isSignUp = false;
    });
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
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              const Text(
                'Welcome',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                margin: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(40)),
                child: TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Name',
                      labelText: 'Name',
                      prefixIcon: Icon(Icons.person)),
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
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'email',
                      labelText: 'email',
                      prefixIcon: Icon(Icons.email)),
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
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Phone Number',
                      labelText: 'Phone Number',
                      prefixIcon: Icon(Icons.phone)),
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
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              GestureDetector(
                onTap: () {
                  if (nameController.text.length == 0) {
                    toastMessage('name cannot be empty', Colors.red);
                  } else if (nameController.text.length < 2) {
                    toastMessage(
                        'name must be greater than 3 digit', Colors.red);
                  } else if (phoneController.text.length == 0) {
                    toastMessage('phone number cannot be empty', Colors.red);
                  } else if (phoneController.text.length < 7) {
                    toastMessage('phone number must be 7 digit', Colors.red);
                  } else if (passwordController.text.length == 0) {
                    toastMessage('password cannot be empty', Colors.red);
                  } else if (passwordController.text.length < 5) {
                    toastMessage('password must be 6 digit', Colors.red);
                  } else {
                    getSignup();
                  }

                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => SignUpScreen()));
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
                  child: isSignUp == true
                      ? CircularProgressIndicator()
                      : Text(
                          'Sign Up',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
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
                          builder: (context) => const SignInOptionScreen()));
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
                              text: 'Login',
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
}
