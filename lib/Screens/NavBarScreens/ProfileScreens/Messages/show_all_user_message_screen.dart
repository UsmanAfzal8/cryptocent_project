import 'dart:convert';
import 'package:crypto_cent/Utils/color.dart';
import 'package:crypto_cent/Utils/url.dart';
import 'package:crypto_cent/widgets/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import '../../../../Models/MessagesModels/chat_history_model.dart';
import 'show_messages.dart';

class ShowAllUsersMessageScreen extends StatefulWidget {
  const ShowAllUsersMessageScreen({Key? key}) : super(key: key);

  @override
  State<ShowAllUsersMessageScreen> createState() => _ShowAllUsersMessageScreenState();
}

class _ShowAllUsersMessageScreenState extends State<ShowAllUsersMessageScreen> {

  var pageNumber = 1;
  var userToken;
  var userId;
  bool isLoadAllChat = false;
  List<ChatHistoryData>? chatHistoryModelObject = [];

  getSharedPreference() async {
    setState(() {
      isLoadAllChat = true;
    });
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userToken = sharedPreferences.getString('userToken');
    userId = sharedPreferences.getString('userId');
    print("userId in sharedPrefs: $userId");
    print("userToken in sharedPrefs: $userToken");

    userChatHistoryApi();
  }

  userChatHistoryApi() async {
    setState(() {
      isLoadAllChat = true;
    });
    Map body = {
      'page': pageNumber.toString(),
    };
    http.Response response = await http.post(Uri.parse(chatHistoryApiUrl+userId),
        body: body,
        headers: {
          'Authorization': 'Bearer $userToken',
          "Accept": "application/json"
        });
    Map jsonData = jsonDecode(response.body);
    print("chatHistoryApiUrl: ${chatHistoryApiUrl+userId}");
    print("chatHistoryLength: ${chatHistoryModelObject!.length}");
    print('chatHistoryApiResponse ==' + jsonData.toString());
    if (jsonData['message'] == 'Chat Not found') {
      // toastMessage("Chat Not found", Colors.red);
      print('Chat not found!');
      setState(() {
        isLoadAllChat = false;
      });
    }
    else if (response.statusCode == 200) {
      for (int i = 0; i < jsonData['data'].length; i++) {
        Map<String, dynamic> obj = jsonData['data'][i];
        print(obj['id']);
        var pos = ChatHistoryData();
        pos = ChatHistoryData.fromJson(obj);
        chatHistoryModelObject!.add(pos);
        print("showAllMessagesLength: ${chatHistoryModelObject!.length}");
        setState(() {
          isLoadAllChat = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getSharedPreference();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: kBlack),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: kBlack),
        title: Text('Messages',
          style: TextStyle(color: kBlack, fontSize: 20),
        ),
        backgroundColor: kWhite,
      ),
      body: isLoadAllChat == true ? Center(child: CircularProgressIndicator()) :
      chatHistoryModelObject!.isEmpty ? Center(child: Text("Chat Not found")):
      SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.85,
              child: ListView.builder(
                // physics: BouncingScrollPhysics(),
                  itemCount: chatHistoryModelObject!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => ShowMessages(
                          name: chatHistoryModelObject![index].sender!.name,
                        )));
                      },
                      child: Container(
                        // margin: EdgeInsets.symmetric(horizontal: 10, vertical: 05),
                        child: ListTile(
                          leading:  CircleAvatar(
                            radius: 26,
                          ),
                          title: Text(
                            "${chatHistoryModelObject![index].sender!.name}",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          subtitle: Text('${chatHistoryModelObject![index].message}'),
                          // trailing: Text('Yesterday'),
                        ),
                      ),
                    );
                  }),
            ),
           ],
        ),
      ),
    );
  }
}
