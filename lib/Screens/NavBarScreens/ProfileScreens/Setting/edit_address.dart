import 'dart:convert';
import 'package:crypto_cent/Utils/color.dart';
import 'package:crypto_cent/Utils/url.dart';
import 'package:crypto_cent/widgets/toast_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Authentication/SignUp/signup_screen.dart';
import '../DeliveryAddress/show_all_addresses.dart';

class EditAddressScreen extends StatefulWidget {

  final String? myName, myPhone, myAddress, myCity, myState, myZipCode;
  const EditAddressScreen({Key? key,
    this.myName, this.myPhone, this.myAddress,
    this.myCity, this.myState, this.myZipCode}) : super(key: key);

  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {

  var fullNameController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var zipCodeController = TextEditingController();

  bool loading = false;
  getSharedPreference() async {
    setState(() {
      loading = true;
    });
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userToken = sharedPreferences.getString('userToken');
    userId = sharedPreferences.getString('userId');
    print('token==$userToken');
    print('id==$userId');
    setState(() {
      loading = true;
    });
    setData();
  }

  @override
  void initState() {
    super.initState();
    getSharedPreference();
  }

  setData() {
    fullNameController.text = widget.myName.toString();
    phoneController.text = widget.myPhone.toString();
    addressController.text = widget.myAddress.toString();
    cityController.text = widget.myCity.toString();
    stateController.text = widget.myState.toString();
    zipCodeController.text = widget.myZipCode.toString();
  }

  updateAddressApiWidget() async {
    setState(() {
      loading = true;
    });
    // try {
    String apiUrl = updateAddressApiUrl+userId;
    print("changeAddressApiUrl: $apiUrl");
    print("userToken $userToken");
    print("userId $userId");
    print("name ${fullNameController.text.toString()}");
    print("phone ${phoneController.text.toString()}");
    print("address ${addressController.text.toString()}");
    print("city ${cityController.text.toString()}");
    print("state ${stateController.text.toString()}");
    print("zipCode ${zipCodeController.text.toString()}");

    http.Response response = await http.post(
        Uri.parse(apiUrl),
        body: {
          "name": fullNameController.text.toString(),
          "phone": phoneController.text.toString(),
          "address": addressController.text.toString(),
          "city": cityController.text.toString(),
          "state": stateController.text.toString(),
          "zip_code": zipCodeController.text.toString(),
        },
        headers: {
          'Authorization': 'Bearer $userToken',
          "Accept": "application/json"
        }
    );
    final responseString = response.body;
    var jsonData = jsonDecode(response.body);
    print("response String: $responseString");
    if(jsonData["message"] == "Address Updated Successfully !"){
      print("Address Updated Successfully !");
      toastMessage("Address Updated Successfully !", Colors.green);
    }
    else{
      // toastMessage("Address Updated Error  !", Colors.red);
    }

    setState(() {
      loading = false;
    });
    // } catch (e) {
    //   print('updatePassword error in catch = ${e.toString()}');
    //   return null;
    // }
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
                    'Edit Delivery Address',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const Icon(CupertinoIcons.ellipsis_vertical),
                ],
              ),
            ),

            updateAddressTextFormFields(),

            GestureDetector(
              onTap: () async {
                if (formKeyUpdateAddress.currentState!.validate()) {
                  // if(updateAddressModelObject!.status == "success"){
                    await updateAddressApiWidget().then((value){
                      print("Address Updated Successfully... !");
                      toastMessage("Address Updated Successfully !", Colors.green);
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => ShowAllAddress()));
                    });
                  // }
                  // else {
                  //   toastMessage("error in update", Colors.red);
                  // }

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
                  child: Text('Update',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
                  )),
            ),
          ],
        ),
      ),
    ));
  }
  GlobalKey<FormState> formKeyUpdateAddress = GlobalKey<FormState>();
  Widget updateAddressTextFormFields() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Form(
          key: formKeyUpdateAddress,
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 10),
                margin: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    color: grey100,
                    //border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(40)),
                child: TextFormField(
                  controller: fullNameController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '${widget.myName}',
                    labelText: 'Full Name',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Name";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 10),
                margin: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    color: grey100,
                    //border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(40)),
                child: TextFormField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '${widget.myPhone}',
                    labelText: 'Phone Number',
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Phone";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 10),
                margin: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    color: grey100,
                    //  border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(40)),
                child: TextFormField(
                  controller: addressController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '${widget.myAddress}',
                    labelText: 'Address',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Address";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 10),
                margin: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    color: grey100,
                    //border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(40)),
                child: TextFormField(
                  controller: cityController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '${widget.myCity}',
                    labelText: 'City',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter City";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 10),
                margin: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    color: grey100,
                    //  border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(40)),
                child: TextFormField(
                  controller: stateController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '${widget.myState}',
                    labelText: 'State',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter State";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 10),
                margin: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    color: grey100,
                    //   border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(40)),
                child: TextFormField(
                  controller: zipCodeController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '${widget.myZipCode}',
                    labelText: 'Zip code',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter ZipCode";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.06,),
            ],
          ),
        ),
      ],
    );
  }
}
