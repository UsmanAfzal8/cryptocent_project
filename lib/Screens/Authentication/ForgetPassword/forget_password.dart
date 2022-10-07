import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../Utils/color.dart';
import 'otp_verified_screen.dart';

enum MobileVerificationState { SHOW_MOBILE_FROM_STATE, SHOW_OTP_FROM_STATE }

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FROM_STATE;
  var phoneController = TextEditingController();
  var otpController = TextEditingController();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String? myVerificationId;
  bool showLoading = false;

  getMobileFormWidget(context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/images/wel.jpg",
              fit: BoxFit.fill,
              width: MediaQuery.of(context).size.width,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: const Text(
                  'Reset your Password',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(context).size.width,
              child: const Text(
                'Please enter your number. We will send a code to your phone to reset your password.',
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
            ),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade200),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Phone Number',
                        labelText: 'Phone Number',
                        prefixIcon: Icon(Icons.phone)),
                    keyboardType: TextInputType.phone,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Text("add number with country code to get otp"),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
            ),
            Container(
              height: 50,
              width: 150,
              child: TextButton(
                onPressed: () async {
                  setState(() {
                    showLoading = true;
                  });
                  await firebaseAuth.verifyPhoneNumber(
                      phoneNumber: phoneController.text,
                      verificationCompleted: (phoneAuthCredential) async {
                        setState(() {
                          showLoading = false;
                        });
                        // signInWithPhoneAuthCredential(phoneAuthCredential);
                      },
                      verificationFailed: (verificationFailed) async {
                        setState(() {
                          showLoading = false;
                        });
                        //scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(verificationFailed.message!)));
                      },
                      codeSent: (verificationId, resendingToken) async {
                        setState(() {
                          showLoading = false;
                          currentState =
                              MobileVerificationState.SHOW_OTP_FROM_STATE;
                          this.myVerificationId = verificationId;
                        });
                      },
                      codeAutoRetrievalTimeout: (verificationId) async {});
                },
                child: Text(
                  "Send",
                  style: TextStyle(color: kWhite),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(primarycolor),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(10)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(primarycolor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: primarycolor)))),
                // style: ButtonStyle(backgroundColor: MaterialStateProperty.all(primarycolor)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getOtpFormWidget(context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            children: [
              const Image(
                image: AssetImage('assets/images/wel.jpg'),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20),
                width: MediaQuery.of(context).size.width,
                child: const Text(
                  'Enter your 6 digit code',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0, right: 00),
                child: Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade200),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    controller: otpController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter OTP',
                      // labelText: 'Phone Number',
                      // prefixIcon: Icon(Icons.phone)
                    ),
                    // keyboardType: TextInputType.phone,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
              ),
              Container(
                height: 50,
                width: 150,
                child: TextButton(
                  onPressed: () async {
                    PhoneAuthCredential phoneAuthCredential =
                        PhoneAuthProvider.credential(
                            verificationId: myVerificationId!,
                            smsCode: otpController.text);
                    signInWithPhoneAuthCredential(phoneAuthCredential);
                  },
                  child: Text(
                    "Verify",
                    style: TextStyle(color: kWhite),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(primarycolor),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.all(10)),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(primarycolor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: primarycolor)))),
                  // style: ButtonStyle(backgroundColor: MaterialStateProperty.all(primarycolor)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        child: showLoading
            ? Center(child: CircularProgressIndicator())
            : currentState == MobileVerificationState.SHOW_MOBILE_FROM_STATE
                ? getMobileFormWidget(context)
                : getOtpFormWidget(context),
        padding: EdgeInsets.all(20),
      ),
    );
  }

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });

    try {
      final authCredentials =
          await firebaseAuth.signInWithCredential(phoneAuthCredential);
      setState(() {
        showLoading = false;
      });

      if (authCredentials.user != null) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => OtpVerifiedScreen()));
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });
      //scaffoldKey .currentState!.showSnackBar(SnackBar(content: Text(e.message!)));
    }
  }
}
