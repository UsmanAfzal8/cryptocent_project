import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bitcoinScreeen.dart';
import 'sendBitcoinscreen.dart';

class Tabbarview extends StatefulWidget {
  const Tabbarview({Key? key}) : super(key: key);

  @override
  State<Tabbarview> createState() => _TabbarviewState();
}

class _TabbarviewState extends State<Tabbarview> {
  @override
  

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          bottom: TabBar(tabs: <Widget>[
            Text('Recieve',style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),),
Text('Send',style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),),
          ]),
        ),
        body:  TabBarView(
          children: <Widget>[
            ReceiveBTCScreen(),
            SendBitcoinScreen(),
          ],
        ),
      ),
    );
  }
}
