// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// import '../signin_screen.dart';
//
// class MyHomeScreen extends StatefulWidget {
//   @override
//   _MyHomeScreenState createState() => _MyHomeScreenState();
// }
//
// class _MyHomeScreenState extends State<MyHomeScreen> {
//
//   final _auth = FirebaseAuth.instance;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Text("Home Screen"),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: ()async{
//           await _auth.signOut();
//           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInScreen()));
//         },
//         child: Icon(Icons.logout),
//       ),
//     );
//   }
// }