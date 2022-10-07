import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'Screens/Authentication/GoogleSignIn/provider/google_sign_in.dart';
import 'Screens/Authentication/GoogleSignIn/provider/wallet_provider.dart';
import 'Screens/SplashScreen/splash_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
String? userIDFireBase;
String? userTokenFirebase;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load(fileName: '.env');
  userTokenFirebase = await FirebaseMessaging.instance.getToken();
  print("userTokenFirebase: $userTokenFirebase");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      
      providers: [
        ChangeNotifierProvider<GoogleSingInProvider>.value(
          value: GoogleSingInProvider(),
        ),
        ChangeNotifierProvider<WalletProvider>.value(
          value: WalletProvider(),
        ),
      ],
      child: GetMaterialApp(
        title: 'Crypto Cent',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
