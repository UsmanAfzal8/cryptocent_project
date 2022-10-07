// import 'package:flutter/material.dart';
// import 'package:otp_text_field/otp_field.dart';
// import 'package:otp_text_field/style.dart';
// import '../../../Utils/color.dart';
// import 'otp_verified_screen.dart';
//
// class OtpScreen extends StatefulWidget {
//   const OtpScreen({Key? key}) : super(key: key);
//
//   @override
//   State<OtpScreen> createState() => _OtpScreenState();
// }
//
// class _OtpScreenState extends State<OtpScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: kWhite,
//         body: SafeArea(
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 const Image(
//                   image: AssetImage('assets/images/wel.jpg'),
//                 ),
//
//                 SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
//                 Container(
//                   margin: const EdgeInsets.only(left: 20),
//                   width: MediaQuery.of(context).size.width,
//                   child: const Text('Enter your 6 digit code',
//                     style: TextStyle(fontSize: 20,),
//                   ),
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.height * 0.06,),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 10, right: 10),
//                   child: OTPTextField(
//                     length: 6,
//                     width: MediaQuery.of(context).size.width,
//                       contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
//                       // contentPadding = const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
//                     fieldWidth: MediaQuery.of(context).size.width * 0.15,
//                     style: const TextStyle(fontSize: 17),
//                     textFieldAlignment: MainAxisAlignment.spaceAround,
//                     fieldStyle: FieldStyle.box,
//                     onCompleted: (pin) {
//                       print('Completed: ' + pin);
//                     },
//                   ),
//                 ),
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.06,
//                 ),
//                 Container(
//                   //  margin: EdgeInsets.only(left: 20),
//                   width: MediaQuery.of(context).size.width,
//                   margin: const EdgeInsets.only(right: 20, top: 10, left: 20),
//                   child: Row(
//                     //  mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         "Did you don't get code? ",
//                         style: TextStyle(
//                             color: Colors.grey.shade700,
//                             fontSize: 20,
//                             fontWeight: FontWeight.w500),
//                       ),
//                       Text(
//                         'Resend',
//                         style: TextStyle(
//                             color: primarycolor,
//                             fontSize: 20,
//                             fontWeight: FontWeight.w600),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 30, right: 30, top: 80),
//                   child: Center(
//                     child: InkWell(
//                       onTap: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) =>
//                                     const OtpVerifiedScreen()));
//                       },
//                       child: Container(
//                           padding: const EdgeInsets.all(10),
//                           height: MediaQuery.of(context).size.height * 0.07,
//                           width: MediaQuery.of(context).size.width,
//                           decoration: BoxDecoration(
//                               color: primarycolor,
//                               borderRadius: BorderRadius.circular(40)),
//                           alignment: Alignment.center,
//                           child: Text(
//                             'Verify',
//                             style: TextStyle(color: kWhite, fontSize: 26),
//                           )),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//               ],
//             ),
//           ),
//         ));
//   }
// }
