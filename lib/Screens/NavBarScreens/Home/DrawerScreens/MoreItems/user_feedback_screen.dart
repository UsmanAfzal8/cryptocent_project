import 'dart:convert';
import 'package:crypto_cent/Models/user_feedback_model.dart';
import 'package:crypto_cent/Screens/NavBarScreens/nav_bar_screen.dart';
import 'package:crypto_cent/Utils/color.dart';
import 'package:crypto_cent/Utils/url.dart';
import 'package:crypto_cent/widgets/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../Models/get_profile_image_model.dart';
import '../../../../../Models/my_reviews_model.dart';
import '../../../../Authentication/SignUp/signup_screen.dart';

class UserFeedbackScreen extends StatefulWidget {
  final String? productId;
  UserFeedbackScreen({Key? key, this.productId}) : super(key: key);

  @override
  State<UserFeedbackScreen> createState() => _UserFeedbackScreenState();
}

class _UserFeedbackScreenState extends State<UserFeedbackScreen> {

  bool loading = false;
  var feedbackController = TextEditingController();

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
      loading = false;
      callGetImageApi();
    });

  }

  GetProfileImageDataModel? getProfileImageDataModelObject;
  List<MyReviewsData> myReviewsDataObject = [] ;

  callGetImageApi() async {
    loading = true;
    setState(() {});
    print('in getImageApi');
    var response;
    try {
      String apiUrl = "${getImageUrl+userId}";
      print("getImageApi: $apiUrl");
      response = await http.get(Uri.parse(apiUrl),
          headers: {
            'Authorization': 'Bearer $userToken',
            'Accept' : 'application/json'
          }
      );
      print('statusCode ${response.statusCode}');

      print(response);
      if (response.statusCode == 200) {
        final responseString = response.body;
        print("response String: ${responseString.toString()}");
        getProfileImageDataModelObject = getProfileImageDataModelFromJson(responseString);
        print("mName: ${getProfileImageDataModelObject!.data!.name}");
        print("mImage: ${getProfileImageDataModelObject!.data!.image}");
      }
    } catch (e) {
      print('Error: ${e.toString()}');
    }
    setState(() {
      loading = false;
      reviewsApiWidget(userToken);
    });
  }
  reviewsApiWidget(String token) async {
    setState(() {
      loading = true;
    });
    http.Response response = await http.get(Uri.parse(myReviewsApiUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept' : 'application/json'
        });
    Map jsonData = jsonDecode(response.body);
    print("reviewsApi: ${myReviewsApiUrl}");
    print("statusCode: ${response.statusCode}");
    print("userToken: $token");
    if (response.statusCode == 200) {
      for (int i = 0; i < jsonData['data'].length; i++) {
        Map<String, dynamic> obj = jsonData['data'][i];
        var pos = MyReviewsData();
        pos = MyReviewsData.fromJson(obj);
        myReviewsDataObject.add(pos);
        print("reviewsLength: ${myReviewsDataObject.length}");
        print("reviewsId: ${myReviewsDataObject[i].id}");
      }
      setState(() {
        loading = false;
      });
    }
  }

  UserFeedBackData? userFeedBackDataObject;

  callUserFeedBackApi() async {
    Map body = {
      'review': "5",
      'comment': feedbackController.text,
      'product_id': widget.productId,
      'user_id': userId,
    };
    http.Response response = await http.post(Uri.parse(myFeedBackApiUrl),
        body: body,
        headers: {
          'Authorization': 'Bearer $userToken',
          'Accept' : 'application/json'
        });
    print("feedbackApi: $myFeedBackApiUrl");
    print("feedbackController: ${feedbackController.text}");
    print("productId: ${widget.productId}");
    print("userId: $userId");
    print("feedbackStatusCode: ${response.statusCode}");

    Map jsonData = jsonDecode(response.body);
    print("jsonResponse: ${jsonData.toString()}");
    // if (response.statusCode == 200) {
    //
    // }
  }

  @override
  void initState() {
    super.initState();
    getSharedPreference();
    print("proID: ${widget.productId}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        iconTheme: IconThemeData(color: kBlack),
        title: Text('User Feedback',
          style: TextStyle(color: kBlack, fontSize: 20),
        ),
        backgroundColor: kWhite,
      ),
      body:
      loading == true ? Center(child: CircularProgressIndicator(),) :
      SingleChildScrollView(
          child: Column(
        children: [

          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            color: cyanColor,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                getProfileImageDataModelObject!.data!.image == null? ClipRRect(
                    borderRadius: BorderRadius.circular(80),
                    child: Image.asset('assets/icons/fade_in_image.jpeg')):
                ClipRRect(
                  borderRadius: BorderRadius.circular(80),
                  child: FadeInImage(
                    placeholder: AssetImage("assets/icons/fade_in_image.jpeg"),
                    fit: BoxFit.fill,
                    height: 150, width: 150,
                    image: NetworkImage(getProfileImageDataModelObject!.data!.image!),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Text('${getProfileImageDataModelObject!.data!.name}',
                  style: TextStyle(fontSize: 18,
                      fontWeight: FontWeight.bold, color: kBlack),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Text('Reviews ${myReviewsDataObject.length}',
                  style: TextStyle(fontSize: 18,
                      fontWeight: FontWeight.w500, color: kBlack),
                ),
              ],
            ),
          ),

          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                const Text('How was your overall experience?',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                // SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                // const Text('How was your overall experience?'),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02,),

                feedBackTextFormFields(),

                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                GestureDetector(
                  onTap: () async {
                    if (formKeyFeedBack.currentState!.validate()) {
                        print("Review inserted successfully!!");
                        await callUserFeedBackApi().then((value) {
                          setState(() {
                            toastMessage("Review inserted successfully!!...", Colors.green);
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => const NavBarScreen()));
                          });
                        });
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    // width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                    decoration: BoxDecoration(
                      color: primarycolor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: .4,
                          blurRadius: 1,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    // margin: const EdgeInsets.only(left: 10, right: 10),
                    child: loading == true ? Center(child: CircularProgressIndicator()) :
                    Text('Submit', style: TextStyle(fontSize: 18, color: kWhite)),
                  ),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }

  GlobalKey<FormState> formKeyFeedBack = GlobalKey<FormState>();
  Widget feedBackTextFormFields() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Form(
          key: formKeyFeedBack,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300)
                ),
                child: TextFormField(
                  controller: feedbackController,
                  maxLines: 10,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Come on, Write your comment '),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter your feedBack";
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
