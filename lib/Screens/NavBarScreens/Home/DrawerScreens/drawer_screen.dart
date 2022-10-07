import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../DrawerScreens/MoreItems/Menu/menu_screen.dart';
import '../DrawerScreens/MoreItems/my_reiews_screen.dart';
import '../DrawerScreens/MoreItems/notification_screen.dart';
import '../DrawerScreens/MoreItems/search_screen.dart';
import '../DrawerScreens/MoreItems/user_feedback_screen.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.5,
      // color: context.theme.canvasColor,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 150,
              width: 40,
              child: DrawerHeader(
                  decoration: const BoxDecoration(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(CupertinoIcons.back)),
                      const Text('More',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(CupertinoIcons.xmark)),
                    ],
                  )),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            ListTile(
              leading: const Icon(Icons.search),
              title: const Text('Search', style: TextStyle(fontSize: 20.0),),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const SearchScreen()));
              },
            ),
            const SizedBox(height: 10,),
            ListTile(
              leading: const Icon(Icons.menu),
              title: const Text('menu', style: TextStyle(fontSize: 20.0),),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const MenuScreen()));
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notifications', style: TextStyle(fontSize: 20.0),),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const NotificationScreen()));
              },
            ),
            // const SizedBox(height: 10,),
            // ListTile(
            //   leading: const Icon(Icons.feedback_outlined),
            //   title: const Text('Feedback', style: TextStyle(fontSize: 20.0),),
            //   onTap: () {
            //     Navigator.push(context, MaterialPageRoute(
            //             builder: (context) => UserFeedbackScreen()));
            //   },
            // ),
            const SizedBox(height: 10,),
            ListTile(
              leading: const Icon(Icons.reviews_outlined),
              title: const Text('My Reviews', style: TextStyle(fontSize: 20.0),),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const MyReviewsScreen()));
              },
            ),
            const SizedBox(height: 10,),
            ListTile(
              leading: const Icon(CupertinoIcons.question_circle),
              title: const Text(
                'Need Help',
                style: TextStyle(fontSize: 20.0),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
