import 'package:crypto_cent/Models/update_profile_model.dart';
import 'package:crypto_cent/Utils/color.dart';
import 'package:crypto_cent/Utils/url.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../Authentication/SignUp/signup_screen.dart';
import '../Setting/setting_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  DateTime selectedDate = DateTime.now();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var genderController = TextEditingController();
  var passwordController = TextEditingController();

  UpdateProfileModel? updateProfileModelObject;
  bool loading = false;
  SharedPreferences? sharedPreferences;

  getSharedPreference() async {
    setState(() {
      loading = true;
    });
    sharedPreferences = await SharedPreferences.getInstance();
    userToken = sharedPreferences!.getString('userToken');
    userId = sharedPreferences!.getString('userId');
    print('token==$userToken');
    print('id==$userId');
    setState(() {
      loading = true;
    });
  }

  updateUser() async {

    setState(() {
      loading = true;
    });
    try {
      String apiUrl = updateProfileApiUrl + userId;
      print("profileApiUrl: $apiUrl");

      print("newName: ${nameController.text}");
      print("newPass: ${passwordController.text}");
      print("newPhone: ${phoneController.text}");
      print("selectedDate: ${selectedDate.toString()}");
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          "name": nameController.text,
          "phone": phoneController.text,
          "gender": genderController.text,
          "date_of_birth": selectedDate.toString(),
          "password": passwordController.text,
        },
          headers: {
          'Authorization': 'Bearer $userToken',
            "Accept": "application/json"
        }
      );
      final responseString = response.body;
      print("response $responseString");
      print("statusCode: ${response.statusCode}");
      print("${response.statusCode}");
      if (response.statusCode == 200) {
        print("resS $responseString");
        updateProfileModelObject = updateProfileModelFromJson(response.body);

      }
    } catch (e) {
      print(' error in catch = ${e.toString()}');
    }

    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getSharedPreference();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        print("selectedDate: ${selectedDate.toLocal()}");
      });
    }
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
                      child: const Icon(
                        CupertinoIcons.back,
                      )),
                  const Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Icon(
                    CupertinoIcons.ellipsis_vertical,
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
            updateProfileTextFormFields(),
            GestureDetector(
              onTap: () async {
                if (formKeyUpdateProfile.currentState!.validate()) {
                  await updateUser().then((value) async {
                    Fluttertoast.showToast(
                        msg: "Profile Updated Successfully !",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    await sharedPreferences!.setString('username', nameController.text);
                    print("name: ${nameController.text}");
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => SettingScreen()));
                  });
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
                  child: const Text('Save',
                    style: TextStyle(fontSize: 20,
                        fontWeight: FontWeight.w500, color: Colors.white),
                  )),
            ),
          ],
        ),
      ),
    ));
  }

  GlobalKey<FormState> formKeyUpdateProfile = GlobalKey<FormState>();
  Widget updateProfileTextFormFields() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Form(
          key: formKeyUpdateProfile,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 20, right: 10),
                margin: const EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200, borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Name",
                    labelStyle: TextStyle(color: Colors.grey),
                    fillColor: Colors.grey[200],
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Name";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 10),
                margin: const EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200, borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Phone Number",
                    labelStyle: TextStyle(color: Colors.black),
                    fillColor: Colors.grey[200],
                  ),

                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Phone";
                    }
                    return null;
                  },

                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 10),
                margin: const EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200, borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  controller: genderController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Gender",
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Gender";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              GestureDetector(
                onTap: () {
                  _selectDate(context);
                },
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 20, right: 10, top: 22, bottom: 22),
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200, borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${selectedDate.toLocal()}".split(' ')[0]),
                      Text('Select date of birth'),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Container(
                  padding: const EdgeInsets.only(left: 20, right: 10),
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200, borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                      controller: passwordController,
                      // obscureText: _obscureText,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter Password";
                        }
                        if(value.length < 5){
                          return "Password must be of 8 characters";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                          labelStyle: TextStyle(color: Colors.black),
                          labelText: 'Enter password'))),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
            ],
          ),
        ),
      ],
    );
  }

}
