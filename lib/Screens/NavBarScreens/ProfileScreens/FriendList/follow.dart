import 'package:crypto_cent/Utils/color.dart';
import 'package:flutter/material.dart';
import 'friends.dart';
import 'registered_user.dart';

class FollowScreen extends StatefulWidget {
  const FollowScreen({Key? key}) : super(key: key);

  @override
  _FollowScreenState createState() => _FollowScreenState();
}

class _FollowScreenState extends State<FollowScreen> with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: kBlack),
        title: Text('Contacts',
          style: TextStyle(color: kBlack, fontSize: 20),
        ),
        backgroundColor: kWhite,
      ),
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
          Container(
            height: 45,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(25.0,),
            ),
            child: TabBar(
              controller: _tabController,
              // give the indicator a decoration (color and border radius)
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0,),
                color: cyanColor,
              ),
              labelColor: kBlack,
              unselectedLabelColor: kWhite,
              tabs: const [
                Tab(text: 'All Registered Users',),
                // second tab [you can add an icon using the icon property]
                Tab(text: 'My Friends',),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                RegisteredUsersScreen(),
                FriendScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
