import 'dart:convert';
import 'package:crypto_cent/Models/update_password_model.dart';
import 'package:crypto_cent/Screens/Authentication/signin_screen.dart';
import 'package:crypto_cent/Screens/NavBarScreens/ProfileScreens/profile_screen.dart';
import 'package:crypto_cent/Utils/url.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Utils/color.dart';
import '../../../widgets/toast_message.dart';
import 'package:http/http.dart' as http;
import '../SignUp/signup_screen.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  var oldPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var confirmNewPasswordController = TextEditingController();
  String? userPassword;

  UpdatePasswordModel? updatePasswordModelObject;

  updateUserPassword() async {
    // try {
      String apiUrl = updatePasswordApiUrl+userId;
      print("changePasswordApiUrl: $apiUrl");
      print("oldPassword: ${oldPasswordController.text}");
      print("newPass: ${newPasswordController.text}");
      print("ConfirmPass: ${confirmNewPasswordController.text}");
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          "oldPassword": oldPasswordController.text.toString(),
          "newPassword": newPasswordController.text.toString(),
          // "status": 1,
        },
          headers: {
            'Authorization': 'Bearer $userToken',
            'Accept': 'application/json'
          }
      );
      final responseString = response.body;
      var jsonData = jsonDecode(response.body);

      print("response String: $responseString");

      print("status Code UpdatePassword: ${response.statusCode}");
      if(jsonData["status"] == "success"){
        toastMessage("Password Changed Successfully", Colors.green);
      }
      else if (response.statusCode == 200) {
        print("resS $responseString");
        if (responseString != 'false') {
          updatePasswordModelObject = updatePasswordModelFromJson(responseString);
          setState(() {});
        }
      }
    // } catch (e) {
    //   print('updatePassword error in catch = ${e.toString()}');
    //   return null;
    // }
  }
  bool loading = false;

  getSharedPreference() async {
    setState(() {
      loading = true;
    });
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userToken = sharedPreferences.getString('userToken');
    userId = sharedPreferences.getString('userId');
    userPassword = sharedPreferences.getString('userPassword');
    print('token==$userToken');
    print('id==$userId');
    print('password==$userPassword');
    setState(() {
      loading = true;
    });
  }

  @override
  void initState() {
    super.initState();
    getSharedPreference();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Change Password", style: TextStyle(color: kBlack),),
          centerTitle: true,
          backgroundColor: kWhite,
          iconTheme: IconThemeData(color: kBlack),
          automaticallyImplyLeading: false,
          elevation: 2,
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                  height: 20, width: 20, color: Colors.transparent,
                  child: const Icon(CupertinoIcons.back))),
        ),

        backgroundColor: kWhite,
        body: SingleChildScrollView(
          child: Column(
            children: [

              updatePasswordTextFormFields(),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 80),
                child: Center(
                  child: GestureDetector(
                    onTap: () async {
                      print("clicked");
                      if (formKeyUpdatePassword.currentState!.validate()) {
                        if(newPasswordController.text == confirmNewPasswordController.text){
                          print("change password Success");
                          await updateUserPassword().then((value) {
                            setState(() {
                              toastMessage("Change Password Success...", Colors.green);
                              Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => const ProfileScreen()));
                            });
                          });
                        }
                        else if(newPasswordController.text != confirmNewPasswordController.text){
                          toastMessage("error in password", Colors.green);
                        }
                      }
                    },
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: primarycolor,
                            borderRadius: BorderRadius.circular(40)),
                        alignment: Alignment.center,
                        child: Text('Update Password',
                          style: TextStyle(color: kWhite,
                              fontSize: 20, fontWeight: FontWeight.w500),
                        )),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
  GlobalKey<FormState> formKeyUpdatePassword = GlobalKey<FormState>();
  Widget updatePasswordTextFormFields() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Form(
          key: formKeyUpdatePassword,
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                margin: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    color: grey100,
                    //border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(40)),
                child: TextFormField(
                  controller: oldPasswordController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Old Password',
                      // enabled: false,
                      // labelText: userPassword.toString(),
                      labelText: 'Old Password',
                      prefixIcon: Icon(Icons.lock)),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter OldPassword";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                margin: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    color: grey100,
                    //  border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(40)),
                child: TextFormField(
                  controller: newPasswordController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'New Password',
                      labelText: 'New Password',
                      prefixIcon: Icon(Icons.lock)),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter newPassword";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                margin: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    color: grey100,
                    //  border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(40)),
                child: TextFormField(
                  controller: confirmNewPasswordController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Confirm New Password',
                      labelText: 'Confirm New Password',
                      prefixIcon: Icon(Icons.lock)),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter new Confirm Password";
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
