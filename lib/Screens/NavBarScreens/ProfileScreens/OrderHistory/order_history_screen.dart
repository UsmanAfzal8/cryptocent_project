import 'package:crypto_cent/Utils/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'all_order_screen.dart';
import 'previous_order_screen.dart';
import 'running_order_screen.dart';

String? forMateDate;
var myFormat = DateFormat('dd-MM-yyyy hh:mm');

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool isAll = false;
  bool isRunning = false;
  bool isPrevious = false;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            iconTheme: IconThemeData(color: kBlack),
            title: Text('Order History',
              style: TextStyle(color: kBlack, fontSize: 20),
            ),
            backgroundColor: kWhite,
          ),
      //backgroundColor: Colors.red,
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              height: 40,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: primarycolor,
                ),
                labelStyle: const TextStyle(fontSize: 16),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                labelPadding: const EdgeInsets.symmetric(horizontal: 10,),
                tabs: [
                  Container(
                    child: Tab(text: 'All',),
                  ),
                  Container(
                    // padding: EdgeInsets.all(10),
                    // decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(00)),
                    child: Tab(text: 'Running',),
                  ),
                  Container(
                    child: Tab(text: 'Previous',),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  AllOrdersScreen(),
                  RunningOrdersScreen(),
                  PreviousOrderScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
