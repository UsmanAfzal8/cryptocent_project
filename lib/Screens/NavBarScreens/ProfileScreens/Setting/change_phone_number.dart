import 'package:crypto_cent/Utils/color.dart';
import 'package:crypto_cent/Utils/url.dart';
import 'package:crypto_cent/widgets/toast_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChangePhoneScreen extends StatefulWidget {
  const ChangePhoneScreen({Key? key}) : super(key: key);

  @override
  State<ChangePhoneScreen> createState() => _ChangePhoneScreenState();
}

class _ChangePhoneScreenState extends State<ChangePhoneScreen> {
  TextEditingController newPhoneController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  var id;
  var userId;
  bool mainLoader = false;

  callChangeNumberApi(String token, String id) async {
    Map body = {
      'phone': newPhoneController.text,
    };

    http.Response response = await http.post(
        Uri.parse(updatePhoneNumberUrl + id),
        body: body,
        headers: {
          'Authorization': 'Bearer $token'}
          );
    print(response.body.toString());
    if (response.statusCode == 200) {
      toastMessage('Phone Updated Successfully', Colors.green);
      Navigator.pop(context);
      setState(() {
        mainLoader = false;
      });
    }
    setState(() {
      mainLoader = false;
    });
    // toastMessage('server error', Colors.red);
  }

  getSharedPreference() async {
    setState(() {
      mainLoader = true;
    });
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    id = sharedPreferences.getString('userToken');
    userId = sharedPreferences.getString('userId');

    print('token==$id');
    print('id==$userId');
    callChangeNumberApi(id, userId);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        CupertinoIcons.back,
                      )),
                  Text(
                    'Change Phone number',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Icon(
                    CupertinoIcons.ellipsis_vertical,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              margin: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  color: grey100, borderRadius: BorderRadius.circular(40)),
              child: TextFormField(
                controller: newPhoneController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'New phone number',
                    labelText: 'New phone number',
                    prefixIcon: Icon(Icons.lock)),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              margin: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  color: grey100,
                  // border: Border.all(color: Colors.grey.shade200),
                  borderRadius: BorderRadius.circular(40)),
              child: TextFormField(
                controller: confirmController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Confirm Phone number',
                    labelText: 'Confirm Phone number',
                    prefixIcon: Icon(Icons.phone)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30, right: 30, top: 80),
              child: Center(
                child: InkWell(
                  onTap: () {
                    if (newPhoneController.text.length == 0) {
                      toastMessage('new phone number cannot be empty', Colors.red);
                    } else if (newPhoneController.text.length < 5) {
                      toastMessage(
                          'new phone number length must be greater than 5 digits', Colors.red);
                    } else if (confirmController.text.length == 0) {
                      toastMessage('confirm phone number cannot be empty', Colors.red);
                    } else if (confirmController.text.length < 5) {
                      toastMessage(
                          'confirm phone number length must be greater than 5 digits', Colors.red);
                    } else if (newPhoneController.text !=
                        confirmController.text) {
                      toastMessage(
                          'confirm phone number should be same as phone number', Colors.red);
                    } else {
                      getSharedPreference();
                    }
                  },
                  child: Container(
                      padding: EdgeInsets.all(10),
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: primarycolor,
                          borderRadius: BorderRadius.circular(40)),
                      alignment: Alignment.center,
                      child: mainLoader == true
                          ? Center(child: CircularProgressIndicator(),)
                          : Text('Update Phone number',
                              style: TextStyle(color: Colors.white,
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            )),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    ));
  }
}
