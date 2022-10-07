import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import '../Screens/OffLine/off_line_screen.dart';

connection(BuildContext context) async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    print("conRes M = $connectivityResult");
    // getData();
    // I am connected to a mobile network.
  } else if (connectivityResult == ConnectivityResult.wifi) {
    print("conRes W= $connectivityResult");
    // getData();

    // I am connected to a wifi network.
  } else {
    print("conRes = $connectivityResult");
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => OfflineUI()))
        .then((value) {
      print(".then is ok");
      // getData();
    });
  }
}