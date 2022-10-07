import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../NavBarScreens/Home/home_screen.dart';
import '../../signin_screen.dart';

class HomePageSignIn extends StatelessWidget {
  const HomePageSignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator());
            }
            else if(snapshot.hasData){
              return const HomeScreen();
            }
            else if(snapshot.hasError){
              return const Center(child: Text("something went wrong"));
            } else{
              return const SignInScreen();
            }
          }),
    );
  }
}
