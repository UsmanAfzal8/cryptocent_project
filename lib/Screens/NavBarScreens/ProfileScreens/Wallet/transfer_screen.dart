import 'package:crypto_cent/Utils/color.dart';
import 'package:flutter/material.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({Key? key}) : super(key: key);

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Transfer',
          style: TextStyle(color: kBlack, fontSize: 20),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: kBlack),
          onPressed: () => Navigator.of(context).pop(),
        ),
        iconTheme: IconThemeData(color: kBlack),
        backgroundColor: kWhite,
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Contacts',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                Icon(
                  Icons.search,
                  color: primarycolor,
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Container(
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: [
                getUser('assets/images/welcome.jpg', 'Sophia', 'Canada'),
                getUser('assets/images/welcome.jpg', 'Sophia', 'Canada'),
                getUser('assets/images/welcome.jpg', 'Sophia', 'Canada'),
                getUser('assets/images/welcome.jpg', 'Sophia', 'Canada'),
                getUser('assets/images/welcome.jpg', 'Sophia', 'Canada'),
                getUser('assets/images/welcome.jpg', 'Sophia', 'Canada'),
                getUser('assets/images/welcome.jpg', 'Sophia', 'Canada'),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
        ],
      )),
    );
  }

  Widget getUser(String image, String name, String country) {
    return Container(
      // height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: Colors.grey.shade100,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image(
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                    image: AssetImage(image)),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.02,
              ),
              Text(
                name,
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: primarycolor),
                child: Text(
                  'Send',
                  style: TextStyle(color: kWhite, fontSize: 12),
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.04),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                    border: Border.all(color: primarycolor),
                    borderRadius: BorderRadius.circular(20),
                    color: kWhite),
                child: Text(
                  'Receive',
                  style: TextStyle(color: primarycolor, fontSize: 12),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
