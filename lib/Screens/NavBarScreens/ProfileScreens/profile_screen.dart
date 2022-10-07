import 'dart:convert';
import 'dart:io';
import 'package:crypto_cent/Models/get_profile_image_model.dart';
import 'package:crypto_cent/Models/upload_image_model.dart';
import 'package:crypto_cent/Utils/color.dart';
import 'package:crypto_cent/Utils/url.dart';
import 'package:crypto_cent/widgets/toast_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Authentication/GoogleSignIn/provider/google_sign_in.dart';
import '../../SplashScreen/welcome_screen.dart';
import '../Home/DrawerScreens/drawer_screen.dart';
import 'FriendList/follow.dart';
import 'Messages/show_all_user_message_screen.dart';
import 'OrderHistory/order_history_screen.dart';
import 'Wallet/wallet_screen.dart';
import 'Setting/setting_screen.dart';
import 'DeliveryAddress/show_all_addresses.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var token;
  var userId;
  File? imageFile;
  var resJson;
  String? image;
  bool loader = false;

  Future pickCoverImage(ImageSource source) async {
    try {
      final selectedImage = await ImagePicker().pickImage(source: source);
      if (selectedImage == null) return;
      final imageTemporary = File(selectedImage.path);
      setState(() {
        imageFile = imageTemporary;
        print("newImage $imageFile");
        onUploadImage();
      });
    } on PlatformException catch (e) {
      print('Failed to pick image:' + e.toString());
    }
  }

  callGetImageApi() async {
    loader = true;
    setState(() {});
    print('in getImageApi');
    var response;
    try {
      String apiUrl = "${getImageUrl + userId}";
      print("getImageApi: $apiUrl");
      response = await http.get(Uri.parse(apiUrl), headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json'
      });
      print('statusCode ${response.statusCode}');

      print(response.body);
      if (response.statusCode == 200) {
        final responseString = response.body;
        print("response String: ${responseString.toString()}");
        getProfileImageDataModelObject =
            getProfileImageDataModelFromJson(responseString);
        print("mName: ${getProfileImageDataModelObject!.data!.name}");
        print(
            "mImage: ${notificationImageBaseUrl + getProfileImageDataModelObject!.data!.image!}");
      }
    } catch (e) {
      print('Error: ${e.toString()}');
    }
    loader = false;
    if (mounted) {
      setState(() {});
    }
  }

  onUploadImage() async {
    setState(() {
      loader = true;
    });
    var request =
        http.MultipartRequest('POST', Uri.parse(imageUploadUrl + userId));
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json'
    };
    print("apiRequest: $request");
    request.files.add(
      http.MultipartFile(
        'image',
        imageFile!.readAsBytes().asStream(),
        imageFile!.lengthSync(),
        filename: imageFile!.path.split('/').last,
      ),
    );
    print("uploadImage ${imageFile!.readAsBytes().asStream()}");
    print("uploadImage ${imageFile!.lengthSync()}");
    print("uploadImage ${imageFile!.path.split('/').last}");
    request.headers.addAll(headers);
    print("request: " + request.toString());
    var res = await request.send();
    http.Response response = await http.Response.fromStream(res);
    resJson = jsonDecode(response.body);
    print("jsonResponse $resJson");
    // setState(() {});
    setState(() {
      loader = false;
      getSharedPreference();
    });
  }

  getSharedPreference() async {
    setState(() {
      loader = true;
    });
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString('userToken');
    userId = sharedPreferences.getString('userId');
    print('token==$token');
    print('id==$userId');
    setState(() {
      loader = false;
      callGetImageApi();
    });
  }

  @override
  void initState() {
    super.initState();
    getSharedPreference();
    // callGetImageApi();
  }

  GetProfileImageDataModel? getProfileImageDataModelObject;
  UploadProfileImageModel? uploadProfileImageModelObject;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(color: kBlack),
        ),
        centerTitle: true,
        backgroundColor: cyanColor,
        iconTheme: IconThemeData(color: kBlack),
        automaticallyImplyLeading: false,
        elevation: 1,
        leading: GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer();
              // Navigator.pop(context);
            },
            child: Container(
                height: 20,
                width: 20,
                color: Colors.transparent,
                child: const Icon(Icons.menu))),
      ),
      backgroundColor: kWhite,
      drawer: const DrawerScreen(),
      body: loader == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width,
                    color: cyanColor,
                    child: Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03),
                        Stack(
                          children: [
                            getProfileImageDataModelObject!.data!.image == null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(80),
                                    child: Image.asset(
                                        'assets/icons/fade_in_image.jpeg'))
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(80),
                                    child: FadeInImage(
                                      placeholder: AssetImage(
                                          "assets/icons/fade_in_image.jpeg"),
                                      fit: BoxFit.fill,
                                      height: 120,
                                      width: 120,
                                      image: NetworkImage(
                                          notificationImageBaseUrl +
                                              getProfileImageDataModelObject!
                                                  .data!.image!),
                                    ),
                                  ),
                            Positioned(
                                right: 0,
                                bottom: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    showCoverImageSelectPopUp(context);
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          color: kWhite),
                                      margin: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.15,
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.28),
                                      child: const Icon(CupertinoIcons.camera)),
                                )),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03),
                        Text(
                          "${getProfileImageDataModelObject!.data!.name}",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: kBlack),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrderHistoryScreen()));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2.2,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: primarycolor),
                            child: Row(
                              children: [
                                Icon(
                                  CupertinoIcons.shopping_cart,
                                  size: 30,
                                  color: kWhite,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.04,
                                ),
                                Text(
                                  'My Order \nHistory',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: kWhite),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ShowAllAddress()));
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2.2,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: primarycolor),
                              child: Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.home,
                                    size: 30,
                                    color: kWhite,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.04,
                                  ),
                                  Text(
                                    'Delivery \nAddress',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: kWhite),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FollowScreen()));
                    },
                    child: allTabs(
                        Icon(CupertinoIcons.person), 'Friends', context),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SettingScreen()));
                    },
                    child: allTabs(
                        Icon(CupertinoIcons.settings), 'Settings', context),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const WalletScreen()));
                      },
                      child: allTabs(Icon(Icons.badge), 'Wallet', context)),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ShowAllUsersMessageScreen()));
                    },
                    child: allTabs(Icon(Icons.message), 'Messages', context),
                  ),
                  GestureDetector(
                      onTap: () async {
                        await callLogoutAPi(context).then((value) {
                          toastMessage("LogOut Successfully...!", Colors.green);
                        });
                      },
                      child: allTabs(Icon(Icons.logout), 'Logout', context)),
                  SizedBox(height: 20),
                ],
              ),
            ),
    ));
  }

  Widget allTabs(Icon icon, String name, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: Colors.grey.shade100,
      ),
      margin: const EdgeInsets.only(left: 20, right: 20, top: 15),
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              icon,
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.08,
              ),
              Text(
                name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Icon(CupertinoIcons.forward)
        ],
      ),
    );
  }

  showCoverImageSelectPopUp(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          print('mmm');
          return Scaffold(
              backgroundColor: Colors.transparent,
              body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        height: MediaQuery.of(context).size.height * 0.16,
                        decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(6)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.only(top: 16, left: 10),
                                  child: Icon(
                                    Icons.camera,
                                    color: blackColor,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                    pickCoverImage(ImageSource.camera);
                                  },
                                  child: Container(
                                    margin:
                                        const EdgeInsets.only(left: 8, top: 16),
                                    child: Text(
                                      'Camera',
                                      style: TextStyle(
                                          fontSize: 20, color: blackColor),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.only(top: 16, left: 10),
                                  child: Icon(
                                    Icons.file_copy,
                                    color: blackColor,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                    pickCoverImage(ImageSource.gallery);
                                  },
                                  child: Container(
                                    margin:
                                        const EdgeInsets.only(left: 8, top: 16),
                                    child: Text(
                                      'Gallery',
                                      style: TextStyle(
                                          fontSize: 20, color: blackColor),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ))
                  ]));
        });
  }

  callLogoutAPi(BuildContext context) async {
    http.Response response = await http
        .post(Uri.parse(logout), headers: {'Authorization': 'Bearer $token'});
    print(response.body.toString());
    Map jsonData = jsonDecode(response.body);
    if (jsonData['message'] == 'Logged out') {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.clear();
      final provider =
          Provider.of<GoogleSingInProvider>(context, listen: false);
      provider.logOut();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => WelcomeScreen()),
          (route) => false);
    }
    setState(() {
      loader = false;
    });
  }
}
