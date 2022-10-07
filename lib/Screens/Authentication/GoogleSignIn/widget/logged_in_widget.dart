// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../provider/google_sign_in.dart';
//
// class LoggedInWidget extends StatelessWidget {
//   const LoggedInWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser!;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Logged In Page"),
//         centerTitle: true,
//         actions: [
//           TextButton(
//               onPressed: (){
//                 final provider = Provider.of<GoogleSingInProvider>(context, listen: false);
//                 provider.logOut();
//               },
//               child: const Text("Logout", style: TextStyle(color: Colors.white, fontSize: 16),))
//         ],
//       ),
//       body: Container(
//         alignment: Alignment.center,
//         color: Colors.blueGrey.shade200,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text("Profile", style: TextStyle(fontSize: 25),),
//             SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
//             CircleAvatar(
//               radius: 60,
//               backgroundImage: NetworkImage(user.photoURL!),
//             ),
//             SizedBox(height: MediaQuery.of(context).size.height * 0.01),
//             Text("Name:" +user.displayName!),
//             SizedBox(height: MediaQuery.of(context).size.height * 0.01),
//             Text("Email:" +user.email!),
//           ],
//         ),
//       ),
//     );
//   }
// }
