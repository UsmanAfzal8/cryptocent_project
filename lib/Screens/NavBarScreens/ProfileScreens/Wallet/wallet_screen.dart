import 'package:crypto_cent/Utils/color.dart';
import 'package:flutter/material.dart';

import 'topup_screen.dart';
import 'transfer_screen.dart';
import 'withdraw_screen.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
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
        title: Text(
          'Wallet',
          style: TextStyle(color: kBlack, fontSize: 20),
        ),
        backgroundColor: kWhite,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: cyanColor),
            height: MediaQuery.of(context).size.height * 0.2,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'M Ahmed',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: kBlack),
                      ),
                      Text(
                        'Balance \$2223.2',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: kBlack),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TopupScreen()));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 34),
                      child: Image(
                          color: kBlack,
                          height: 30,
                          image: AssetImage('assets/images/wallet2.png')),
                    ),
                  )
                ]),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TransferScreen()));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: whiteColor),
                      child: Image(
                          //  color: yellowcolor,
                          height: 44,
                          image: AssetImage('assets/icons/transfer.png')),
                    ),

                    //  Container(
                    //     padding: const EdgeInsets.all(10),
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(30),
                    //         color: kWhite),
                    //     child: Icon(
                    //       Icons.currency_exchange_sharp,
                    //       color: yellow800,
                    //     )),
                  ),
                  const Text('Transfer'),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TopupScreen()));
                },
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: whiteColor),
                      child: Image(
                          height: 44,
                          image: AssetImage('assets/icons/icon-02.png')),
                    ),
                    const Text('TopUp'),
                  ],
                ),
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WithScreen()));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: kWhite),
                      child: Image(
                          height: 44,
                          image: AssetImage('assets/icons/withdraw.png')),
                    ),
                  ),
                  const Text('Withdraw'),
                ],
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomLeft,
            child: const Text(
              'Recent Transactions',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          RecentTransaction(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          RecentTransaction(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          RecentTransaction(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          RecentTransaction(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          RecentTransaction(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          RecentTransaction(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          RecentTransaction(),
          const SizedBox(
            height: 40,
          )
        ],
      )),
    );
  }

  Widget RecentTransaction() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: Colors.grey.shade100,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage('assets/images/food.jpeg'),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Food for Lunch',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              const Text('3:02 pm - 12 May 2022')
            ],
          ),
          const Text(
            '-\$12.0',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}
