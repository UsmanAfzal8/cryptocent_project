import 'dart:convert';
import 'package:crypto_cent/Models/my_reviews_model.dart';
import 'package:crypto_cent/Utils/color.dart';
import 'package:crypto_cent/Utils/url.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../../../Models/get_profile_image_model.dart';
import '../../../../Authentication/SignUp/signup_screen.dart';
import '../../../ProfileScreens/OrderHistory/order_history_screen.dart';

class MyReviewsScreen extends StatefulWidget {
  const MyReviewsScreen({Key? key}) : super(key: key);

  @override
  State<MyReviewsScreen> createState() => _MyReviewsScreenState();
}

class _MyReviewsScreenState extends State<MyReviewsScreen> {
  List<MyReviewsData> myReviewsDataObject = [] ;
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
    callGetImageApi();
    reviewsApiWidget(userToken);
  }

  GetProfileImageDataModel? getProfileImageDataModelObject;

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
    });
  }

  reviewsApiWidget(String token) async {
    setState(() {
      loading = true;
    });
    print("asdf");
    http.Response response = await http.get(Uri.parse(myReviewsApiUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept' : 'application/json'
        });
    print("asdfgh");
    Map jsonData = jsonDecode(response.body);
    print("reviewsApi: ${myReviewsApiUrl}");
    print("statusCodeReview: ${response.statusCode}");
    print("userIdReview: $userId");
    print("userTokenReview: $token");
    print("reviewResponse: $jsonData");
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
          title: Text('My Reviews',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: kBlack),
          backgroundColor: kWhite,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios,),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        backgroundColor: kWhite,
        body: loading? Center(child: CircularProgressIndicator()):
        Container(
          height: MediaQuery.of(context).size.height * 0.9,
          // color: Colors.red,
          child: SingleChildScrollView(
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

              loading? Center(child: CircularProgressIndicator()):
              myReviewsDataObject.length < 1 ? Container(
                color: Colors.transparent,
                height: MediaQuery.of(context).size.height * 0.6,
                child: Center(
                  child: Text("No Review found",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                ),
              ):

              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                color: kWhite,
                child: ListView.builder(
                    itemCount: myReviewsDataObject.length,
                    itemBuilder: (context, index) {
                      var dateTimeConverted = DateTime.parse(myReviewsDataObject[index].createdAt.toString());
                      forMateDate = myFormat.format(dateTimeConverted);
                      print('date for myReviews is ${forMateDate}');
                  return Container(
                    margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 1.0)]
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('ProductId: ${myReviewsDataObject[index].productId}',),
                              Text('${forMateDate.toString()}', style: TextStyle(fontSize: 14, color: Colors.black),),
                            ],
                          ),
                          SizedBox(height: 05),
                          Text('${myReviewsDataObject[index].comment}',
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
