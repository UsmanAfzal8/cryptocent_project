import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'home_page.dart';


class FacebookLogin extends StatefulWidget {
  const FacebookLogin({Key? key}) : super(key: key);

  @override
  _FacebookLoginState createState() => _FacebookLoginState();
}

class _FacebookLoginState extends State<FacebookLogin> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Facebook Login",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: _displayLoginButton(),
      ),
    );
  }

  _displayLoginButton() {
    return GestureDetector(
      onTap: () {
        signInWithFacebook();
      },
      child: Container(
        width: 300,
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blue,
            ),
            borderRadius: BorderRadius.circular(10),
            color: Colors.blue
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SignInButton(
              Buttons.Facebook,
              text: "Log in with facebook",
              mini: true,
              onPressed: () {
                signInWithFacebook();
              },
            ),
            const Text("  Log in with facebook", style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20),),
          ],
        ),
      ),
    );
  }

  void signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login(
          permissions: (['email', 'public_profile']));
      final token = result.accessToken!.token;
      print(
          'Facebook token userID : ${result.accessToken!.grantedPermissions}');
      final graphResponse = await http.get(
          Uri.parse('https://graph.facebook.com/'
              'v2.12/me?fields=name,first_name,last_name,email&access_token=${token}'));

      final profile = jsonDecode(graphResponse.body);
      print("Profile is equal to $profile");
      try {
        final AuthCredential facebookCredential = FacebookAuthProvider
            .credential(result.accessToken!.token);
        final userCredential = await FirebaseAuth.instance.signInWithCredential(
            facebookCredential);
        print("userCredentials: $userCredential");
        Navigator.push(context,
          MaterialPageRoute(builder: (context) => const FacebookSuccessPage()),
        );
      } catch (e) {
        final snackBar = SnackBar(
          margin: const EdgeInsets.all(20),
          behavior: SnackBarBehavior.floating,
          content: Text(e.toString()),
          backgroundColor: (Colors.redAccent),
          action: SnackBarAction(
            label: 'dismiss',
            onPressed: () {},
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      print("error occurred");
      print(e.toString());
    }
  }
}
