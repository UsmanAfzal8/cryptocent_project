import 'package:crypto_cent/Utils/color.dart';
import 'package:crypto_cent/Utils/url.dart';
import 'package:crypto_cent/widgets/toast_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'show_all_addresses.dart';

class AddDeliveryAddressScreen extends StatefulWidget {

  AddDeliveryAddressScreen({Key? key}) : super(key: key);

  @override
  State<AddDeliveryAddressScreen> createState() => _AddDeliveryAddressScreenState();
}

class _AddDeliveryAddressScreenState extends State<AddDeliveryAddressScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController zipcodeController = TextEditingController();
  var id;
  var userId;
  bool mainLoader =false;

  callAddDeliveryApi(String token, String id) async {
    Map body = {
      'user_id': id,
      'name': nameController.text,
      'phone': phoneController.text,
      'address': addressController.text,
      'city': cityController.text,
      'state': stateController.text,
      'zip_code': zipcodeController.text,
    };
    http.Response response = await http.post(Uri.parse(addAddressUrl),
        body: body, headers: {'Authorization': 'Bearer $token'});
    print(response.body.toString());
    print("addDeliveryAddressApi: $addAddressUrl");
    Map jsonData = jsonDecode(response.body);
    print("jsonResponse: ${jsonData.toString()}");
    if (response.statusCode == 200) {
      toastMessage('Delivery address inserted successfully!!', Colors.green);
      setState(() {});
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ShowAllAddress()));
    }
    setState(() {
      mainLoader = false;
    });
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

    setState(() {
      mainLoader = false;
    });
    callAddDeliveryApi(id, userId);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(CupertinoIcons.back)),
                  const Text(
                    'Add Delivery Address',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const Icon(CupertinoIcons.ellipsis_vertical),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 10),
              margin: const EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  color: grey100,
                  //   border: Border.all(color: Colors.grey.shade200),
                  borderRadius: BorderRadius.circular(40)),
              child: TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Full Name',
                  labelText: 'Full Name',
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 10),
              margin: const EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  color: grey100,
                  //  border: Border.all(color: Colors.grey.shade200),
                  borderRadius: BorderRadius.circular(40)),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: phoneController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Phone Number',
                  labelText: 'Phone Number',
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 10),
              margin: const EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  color: grey100,
                  //   border: Border.all(color: Colors.grey.shade200),
                  borderRadius: BorderRadius.circular(40)),
              child: TextFormField(
                controller: addressController,
                textAlign: TextAlign.start,
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Address',
                  labelText: 'Address',
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 10),
              margin: const EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  color: grey100,
                  //  border: Border.all(color: Colors.grey.shade200),
                  borderRadius: BorderRadius.circular(40)),
              child: TextFormField(
                controller: cityController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'City',
                  labelText: 'City',
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 10),
              margin: const EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  color: grey100,
                  //  border: Border.all(color: Colors.grey.shade200),
                  borderRadius: BorderRadius.circular(40)),
              child: TextFormField(
                controller: stateController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'State',
                  labelText: 'State',
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 10),
              margin: const EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  color: grey100,
                  //   border: Border.all(color: Colors.grey.shade200),
                  borderRadius: BorderRadius.circular(40)),
              child: TextFormField(
                controller: zipcodeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Zip code',
                  labelText: 'Zip code',
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
            ),
            GestureDetector(
              onTap: () {
                if (nameController.text.length == 0) {
                  toastMessage('full name cannot be empty', Colors.red);
                } else if (nameController.text.length < 3) {
                  toastMessage('full name length must be greater than 3', Colors.red);
                } else if (phoneController.text.length == 0) {
                  toastMessage('phone number cannot be empty', Colors.red);
                } else if (phoneController.text.length < 6) {
                  toastMessage('phone number length must be greater than 6', Colors.red);
                } else if (addressController.text.length == 0) {
                  toastMessage('address cannot be empty', Colors.red);
                } else if (addressController.text.length < 6) {
                  toastMessage('address length must be greater than 6', Colors.red);
                } else if (cityController.text.length == 0) {
                  toastMessage('city cannot be empty', Colors.red);
                } else if (cityController.text.length < 2) {
                  toastMessage('city length must be greater than 3', Colors.red);
                } else if (stateController.text.length == 0) {
                  toastMessage('state cannot be empty', Colors.red);
                } else if (stateController.text.length < 2) {
                  toastMessage('state length must be greater than 3', Colors.red);
                } else if (zipcodeController.text.length == 0) {
                  toastMessage('zip code cannot be empty', Colors.red);
                } else if (zipcodeController.text.length < 2) {
                  toastMessage('zip code length must be greater than 2', Colors.red);
                } else {
                  getSharedPreference();
                }
              },
              child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                      color: primarycolor,
                      border: Border.all(color: Colors.grey.shade200),
                      borderRadius: BorderRadius.circular(40)),
                  child: mainLoader == true? CircularProgressIndicator():
                  Text('Save', style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
                  )),
            ),
          ],
        ),
      ),
    ));
  }
}
