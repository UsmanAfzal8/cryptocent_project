import 'dart:convert';
import 'package:crypto_cent/Utils/url.dart';
import 'package:crypto_cent/widgets/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../../Models/MessagesModels/all_user_chat_model.dart';
import '../../../../Models/MessagesModels/send_message_model.dart';

class ShowMessages extends StatefulWidget {
  final String? name;
  ShowMessages({Key? key, this.name}) : super(key: key);

  @override
  State<ShowMessages> createState() => _ShowMessagesState();
}

class _ShowMessagesState extends State<ShowMessages> {

  final GlobalKey<FormState> _formKeyMessage = GlobalKey<FormState>();
  var messageController = TextEditingController();
  bool isLoadAllProduct = false;
  var userToken;
  var userId;

  SendMessageModel? sendMessageModelObject;
  SharedPreferences? sharedPreferences;
  List<AllUserChatData> allChatModel = [];
  List<SendMessageModel> sendMessageModel = [];

  getSharedPreference() async {
    setState(() {
      isLoadAllProduct = true;
    });
    sharedPreferences = await SharedPreferences.getInstance();
    userToken = sharedPreferences!.getString('userToken');
    userId = sharedPreferences!.getString('userId');
    print("userId in sharedPrefs MessageScreen: $userId");
    print("userToken in sharedPrefs MessageScreen: $userToken");
    allChatMessageApi(userToken);
  }

  @override
  void initState() {
    super.initState();
    getSharedPreference();
    print("followedName: ${widget.name}");
  }

  allChatMessageApi(String token) async {
    Map body = {
      "sender_id": userId,
      "receiver_id": "37",
    };
    http.Response response = await http.post(Uri.parse(allChatApiUrl),
        body: body, headers: {
          'Authorization': 'Bearer $userToken',
        });
    Map jsonData = jsonDecode(response.body);
    print("allChatApi: $allChatApiUrl");
    print("statusCode: ${response.statusCode}");
    print("responseData: $jsonData");

    if (response.statusCode == 200) {
      for (int i = 0; i < jsonData['data'].length; i++) {
        Map<String, dynamic> obj = jsonData['data'][i];

        var pos = AllUserChatData();
        pos = AllUserChatData.fromJson(obj);
        allChatModel.add(pos);
      }
      print("allChatLength: ${allChatModel.length}");
      setState(() {
        isLoadAllProduct = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 4,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          centerTitle: true,
          flexibleSpace: SafeArea(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(right: 16),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios, color: Colors.black,),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.006,),
                  CircleAvatar(
                    // backgroundImage: NetworkImage(
                    //     "<https://randomuser.me/api/portraits/men/5.jpg>"),
                    maxRadius: 20,
                  ),

                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(12),
                  //   child: Image.network(
                  //     productBaseUrl + "${showFollowingObject![index].show!.data![index].followed!.image}",
                  //     fit: BoxFit.fill,
                  //     height: MediaQuery.of(context).size.height * 0.05,
                  //     width: MediaQuery.of(context).size.width * 0.05 ,
                  //   ),
                  // ),

                  SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
                  Text("${widget.name}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                ],
              ),
            ),
          ),
        ),
        body:
        isLoadAllProduct == true ? Center(child: CircularProgressIndicator(),) :
        // sendMessageModelObject!.data!.message!.length < 1 ? Center(child: Text("No Message to show")):
        SingleChildScrollView(
          child: Column(
              children: [
            Container(
              // color: Colors.red,
              height: MediaQuery.of(context).size.height * 0.84,
              child: ListView.builder(
                itemCount: allChatModel.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 10, bottom: 10),
                // physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                    child: Align(
                      alignment:
                          // (messages[index].messageType == "receiver"
                          (allChatModel[index].receiver == "receiver"
                              ? Alignment.topLeft : Alignment.topRight),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          // color: (messages[index].messageType == "receiver"
                          color: (allChatModel[index].receiver!.messengerColor == "receiver"
                                  ? Colors.grey.shade200 : Colors.blue[200]),
                        ),
                        padding: EdgeInsets.all(16),
                        child: Text(
                          // messages[index].messageContent!,
                          "${allChatModel[index].message}",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            Container(
              padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(Icons.add, color: Colors.white, size: 20,),
                    ),
                  ),
                  SizedBox(width: 15,),
                  Expanded(
                    child: Form(
                      key: _formKeyMessage,
                      child: TextFormField(
                        controller: messageController,
                        decoration: InputDecoration(
                            hintText: "Write a message...",
                            // labelText: "Write your message here...",
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please write a message...';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 15,),
                  FloatingActionButton(
                    onPressed: () async {
                      if (_formKeyMessage.currentState!.validate()) {
                        if (messageController.text.isEmpty) {
                          print("please enter a message");
                          toastMessage("please enter a message", Colors.red);
                        }
                        else {
                          await sendMessageApi().then((value) async {
                            // setState(() {
                              getSharedPreference();
                              print("clicked123......");
                              toastMessage("Message Sent Successfully", Colors.green);
                              messageController.clear();
                            // });
                          });
                        }

                      }
                    },
                    child: Icon(Icons.send, color: Colors.white, size: 18,),
                    backgroundColor: Colors.blue,
                    elevation: 0,
                  ),
                ],
              ),
            ),
          ]),
        ));
  }

  sendMessageApi() async {
    print("userToken: $userToken");
    print("userId123: $userId");
    print("senderId: $userId");
    print("receiverId: 37");
    print("message: ${messageController.text}");
    http.Response response = await http.post(Uri.parse(sendMessageApiUrl),
        body: {
          "sender_id": userId,
          "receiver_id": "37",
          "message": messageController.text,
          "attachment": "",
        },
        headers: {
          "Authorization": "Bearer $userToken",
          "Accept": "application/json",
        });
    print("sendMessageApi: $sendMessageApiUrl");
    Map jsonData = jsonDecode(response.body);
    print('jsonResponse: ' + jsonData.toString());
  }
}
