import 'package:flutter/material.dart';
import '../../Utils/color.dart';
import '../../widgets/bootom_navigation_bar.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return ContentWithBottomNavigationBar(
      appbarTitle: 'Messenger',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              children: [
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'JuzGo',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 10,
                      height: 20,
                      decoration:
                          BoxDecoration(shape: BoxShape.circle, color: myColor),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Online',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 0.5,
                      width: MediaQuery.of(context).size.width / 3,
                      color: Colors.grey.shade300,
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      width: MediaQuery.of(context).size.width / 5,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Today',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      height: 0.5,
                      width: MediaQuery.of(context).size.width / 3,
                      color: Colors.grey,
                    ),
                  ],
                ),
                ListView.builder(
                  itemCount: messages.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.only(
                          left: 14, right: 14, top: 10, bottom: 10),
                      child: Align(
                        alignment: (messages[index].messageType == 'receiver'
                            ? Alignment.topLeft
                            : Alignment.topRight),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: (messages[index].messageType == 'receiver'
                                ? Colors.grey.shade200
                                : Colors.blue[200]),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            messages[index].messageContent!,
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
            decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [BoxShadow(color: kGrey, blurRadius: 4.0)]),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: kSkyBlue),
                    child: Icon(
                      Icons.add,
                      color: kWhite,
                    ),
                  ),
                  const Icon(Icons.mic)
                ]),
          )
        ],
      ),
    );
  }

  List<ChatMessage> messages = [
    ChatMessage(messageContent: 'Hello, Will', messageType: 'receiver'),
    ChatMessage(messageContent: 'How have you been?', messageType: 'receiver'),
    ChatMessage(messageContent: 'Hey Kriss, I am doing fine dude. wbu?', messageType: 'sender'),
    ChatMessage(messageContent: 'ehhhh, doing OK.', messageType: 'receiver'),
    ChatMessage(messageContent: 'Is there any thing wrong?', messageType: 'sender'),
  ];
}

class ChatMessage {
  String? messageContent;
  String? messageType;
  ChatMessage({this.messageContent, this.messageType});
}
