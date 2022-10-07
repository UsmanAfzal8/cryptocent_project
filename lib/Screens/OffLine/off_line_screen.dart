import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class OfflineUI extends StatefulWidget {
  @override
  _OfflineUIState createState() => _OfflineUIState();
}

class _OfflineUIState extends State<OfflineUI> {
  connection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      print("conRes M  = $connectivityResult");
      Navigator.of(context).pop();
      /// I am connected to a mobile network.
    } else if (connectivityResult == ConnectivityResult.wifi) {
      print("conRes W= $connectivityResult");
      Navigator.of(context).pop();

      /// I am connected to a wifi network.
    } else {
      print("conRes = $connectivityResult");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("No Internet",
                style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Image.asset('assets/images/offline.jpeg',
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.3,
                fit: BoxFit.fill,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Text("Please Connect To The Internet!"),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.4,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(05)),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.green),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.green)
                          )
                      )
                  ),
                  // color: Colors.green,
                  // shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(25.0)),
                  child: new Text('Retry',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () {
                    connection();
                  },
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
