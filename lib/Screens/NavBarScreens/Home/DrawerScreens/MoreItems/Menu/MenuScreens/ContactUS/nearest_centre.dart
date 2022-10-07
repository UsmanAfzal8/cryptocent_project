// import 'dart:convert';
// import 'package:crypto_cent/Utils/color.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../../../Models/near_center_model.dart';
// import '../../Authentication/SignUp/signup_screen.dart';
//
//
// class NearestCentre extends StatefulWidget {
//   const NearestCentre({Key? key, }) : super(key: key);
//
//   @override
//   State<NearestCentre> createState() => _NearestCentreState();
// }
//
// class _NearestCentreState extends State<NearestCentre> {
//   bool checkConnection = false;
//   bool loader = true;
//   List<NearCenterModel> nearCentre = <NearCenterModel>[];
//
//   callNearCenterApi() async {
//
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     userToken = prefs.getString("userToken");
//
//     http.Response response = await http.get(
//       Uri.parse(
//           "https://accountpos.shoaibkanwalacademy.com/Questionbook/public/api/testcenter"),
//       headers: {"Authorization": "Bearer $userToken"},
//     );
//     print("browser == ${response.body}");
//
//     Map jsonData = jsonDecode(response.body);
//
//     if (response.statusCode == 200) {
//       for (int i = 0; i < jsonData["data"].length; i++) {
//         Map<String, dynamic> object = jsonData["data"][i];
//         // print('latest ==' + object.toString());
//         NearCenterModel nearCenter = NearCenterModel();
//
//         nearCenter = NearCenterModel.fromJson(object);
//         nearCentre.add(nearCenter);
//       }
//       setState(() {
//         loader = false;
//       });
//     }
//   }
//
//   static void navigateTo(String lat, String lng) async {
//     var uri = Uri.parse("google.navigation:q=$lat,$lng&mode=d");
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri);
//     } else {
//       throw 'Could not launch ${uri.toString()}';
//     }
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//             appBar: AppBar(
//               centerTitle: true,
//               backgroundColor: kWhite,
//               elevation: 0,
//               title: Text("near", style: TextStyle(color: Colors.black),),
//               iconTheme: IconThemeData(color: kBlack),
//               leading: InkWell(
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//                 child: const Icon(Icons.arrow_back_ios),
//               ),
//             ),
//             body: Container(
//               height: 500,
//               color: Colors.green,
//               child: ListView.builder(
//                       itemCount: nearCentre.length,
//                       itemBuilder: (context, index) {
//                         return Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: GestureDetector(
//                             onTap: () {
//                               navigateTo(nearCentre[index].lat.toString(),
//                                   nearCentre[index].lng.toString());
//                             },
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 const Text("my Location"),
//                                 SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
//                                 Text(
//                                   nearCentre[index].address.toString(),
//                                   style: const TextStyle(
//                                       fontSize: 30, fontWeight: FontWeight.bold),
//                                 )
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//             ));
//   }
// }
