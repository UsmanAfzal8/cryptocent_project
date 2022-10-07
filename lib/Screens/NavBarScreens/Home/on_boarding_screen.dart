// import 'package:flutter/material.dart';
// // ignore: import_of_legacy_library_into_null_safe
// import 'package:sk_onboarding_screen/sk_onboarding_model.dart';
// // ignore: import_of_legacy_library_into_null_safe
// import 'package:sk_onboarding_screen/sk_onboarding_screen.dart';

// import '../Utils/color.dart';
// import 'welcome_screen.dart';

// class OnBoardingScreen extends StatefulWidget {
//   const OnBoardingScreen({Key? key}) : super(key: key);

//   @override
//   State<OnBoardingScreen> createState() => _OnBoardingScreenState();
// }

// class _OnBoardingScreenState extends State<OnBoardingScreen> {
//   final pages = [
//     SkOnboardingModel(
//         title: 'All Brands and Categories',
//         description: '',
//         titleColor: Colors.black,
//         descripColor: const Color(0xFF929794),
//         imagePath: 'assets/images/icon1.png'),
//     SkOnboardingModel(
//         title: 'Super Discounts and Offers',
//         description: '',
//         titleColor: Colors.black,
//         descripColor: const Color(0xFF929794),
//         imagePath: 'assets/images/icon2.png'),
//     SkOnboardingModel(
//         title: 'Fast Delivery Service',
//         description: '',
//         titleColor: Colors.black,
//         descripColor: const Color(0xFF929794),
//         imagePath: 'assets/images/icon3.png'),
//     SkOnboardingModel(
//         title: 'Easy Payment System',
//         description: '',
//         titleColor: Colors.black,
//         descripColor: const Color(0xFF929794),
//         imagePath: 'assets/images/icon4.png'),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SKOnboardingScreen(
//         bgColor: Colors.white,
//         themeColor: primarycolor,
//         pages: pages,
//         skipClicked: (value) {
//           Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(builder: (context) => WelcomeScreen()),
//               (route) => false);
//         },
//         getStartedClicked: (value) {
//           Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(builder: (context) => WelcomeScreen()),
//               (route) => false);
//         },
//       ),
//     );
//   }
// }
