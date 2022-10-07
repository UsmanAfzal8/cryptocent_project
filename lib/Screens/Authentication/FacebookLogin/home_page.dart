import 'package:flutter/material.dart';

class FacebookSuccessPage extends StatefulWidget {
  const FacebookSuccessPage({Key? key}) : super(key: key);

  @override
  _FacebookSuccessPageState createState() => _FacebookSuccessPageState();
}

class _FacebookSuccessPageState extends State<FacebookSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
      ),
      body: const Center(
        child: Text("Successfully Logged in from Facebook",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
      ),
    );
  }
}