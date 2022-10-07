import 'package:flutter/material.dart';
import '../Utils/color.dart';

class ContentWithBottomNavigationBar extends StatelessWidget {
  const ContentWithBottomNavigationBar(
      {Key? key, this.appBar, required this.body, this.appbarTitle})
      : super(key: key);
  final PreferredSizeWidget? appBar;
  final Widget body;
  final String? appbarTitle;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar ??
          PreferredSize(
              child: SafeArea(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                              height: 30.0,
                              margin: const EdgeInsets.only(left: 20.0),
                              child: Image.asset(kMenu)),
                          Expanded(
                              child: Text(
                            appbarTitle ?? "",
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 18.0),
                          )),
                        ],
                      ),
                      const Spacer(),
                      Divider(
                        color: kSkyBlue,
                        height: 1.2,
                      )
                    ],
                  ),
                ),
              ),
              preferredSize: const Size(double.infinity, kToolbarHeight * 1.2)),
      body: body,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          backgroundColor: kLightRed,
          child: Container(
              margin: const EdgeInsets.all(6.0),
              child: Image.asset(kAppIconWhite)),
          onPressed: () {}),
      bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          elevation: 8.0,
          //  shape: const CircularNotchedRectangle(),
          child: SizedBox(
            height: 56,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                icon(Icons.call),
                icon(Icons.card_travel),
                const SizedBox(width: 40), // The dummy child
                icon(Icons.chat_bubble_outline_rounded),
                icon(Icons.book),
              ],
            ),
          )),
    );
  }

  Widget icon(IconData icon) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
            shape: BoxShape.circle, border: Border.all(color: Colors.grey)),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Icon(icon, color: Colors.grey),
        ));
  }
}
