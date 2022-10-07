import 'package:flutter/material.dart';

import '../../../Utils/color.dart';
import 'change_password.dart';

class OtpVerifiedScreen extends StatefulWidget {
  const OtpVerifiedScreen({Key? key}) : super(key: key);

  @override
  State<OtpVerifiedScreen> createState() => _OtpVerifiedScreenState();
}

class _OtpVerifiedScreenState extends State<OtpVerifiedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              child: const Image(
                image: AssetImage('assets/images/success.png'),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(context).size.width,
              child: const Text('Verified!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(context).size.width,
              child: const Text('Hello! You have successfully \n       verified the account',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 80),
              child: Center(
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                            builder: (context) => const ChangePasswordScreen()));
                  },
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: primarycolor,
                          borderRadius: BorderRadius.circular(40)),
                      alignment: Alignment.center,
                      child: Text('Continue',
                        style: TextStyle(color: kWhite, fontSize: 26),
                      )),
                ),
              ),
            ),
            const SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}
