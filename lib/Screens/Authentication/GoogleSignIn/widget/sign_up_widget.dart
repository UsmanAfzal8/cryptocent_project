// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:provider/provider.dart';
// import '../provider/google_sign_in.dart';
//
// class SignUpWidget extends StatefulWidget {
//   const SignUpWidget({Key? key}) : super(key: key);
//
//   @override
//   _SignUpWidgetState createState() => _SignUpWidgetState();
// }
//
// class _SignUpWidgetState extends State<SignUpWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         alignment: Alignment.center,
//         color: Colors.blueGrey.shade800,
//         child: Padding(
//           padding: EdgeInsets.only(
//               left: MediaQuery.of(context).size.width * 0.04,
//               right: MediaQuery.of(context).size.width * 0.05,
//               top: MediaQuery.of(context).size.height * 0.4,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text("Welcome To Google SignUp", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
//               const Text("Login to your account to continue", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
//               SizedBox(height: MediaQuery.of(context).size.height * 0.05),
//               ElevatedButton.icon(
//                   onPressed: (){
//                     final provider = Provider.of<GoogleSingInProvider>(context, listen: false);
//                     provider.googleLogin();
//                   },
//                   style: ElevatedButton.styleFrom(
//                     primary: Colors.white,
//                     onPrimary: Colors.black,
//                     minimumSize: Size(MediaQuery.of(context).size.width * 0.7, 40),
//
//                   ),
//                   icon: const FaIcon(FontAwesomeIcons.google, color: Colors.blue),
//                   label: const Text("SignUp with Google")),
//
//               // SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//               //
//               // ElevatedButton.icon(
//               //     onPressed: (){
//               //       final provider = Provider.of<GoogleSingInProvider>(context, listen: false);
//               //       provider.googleLogin();
//               //     },
//               //     style: ElevatedButton.styleFrom(
//               //       primary: Colors.white,
//               //       onPrimary: Colors.black,
//               //       minimumSize: Size(MediaQuery.of(context).size.width * 0.7, 40),
//               //
//               //     ),
//               //     icon: const FaIcon(FontAwesomeIcons.facebook, color: Colors.blue),
//               //     label: const Text("SignUp with Facebook")),
//               SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//               const Text("Already have an account? login", style: TextStyle(fontSize: 14),),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
