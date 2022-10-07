import 'package:flutter/material.dart';
import '../../Utils/color.dart';

class UserRegistrationScreen extends StatefulWidget {
  const UserRegistrationScreen({Key? key}) : super(key: key);

  @override
  State<UserRegistrationScreen> createState() => _UserRegistrationScreenState();
}

class _UserRegistrationScreenState extends State<UserRegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhite,
        title: Text(
          'User Registration',
          style: TextStyle(color: kBlack),
        ),
        centerTitle: true,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(4.0),
            child: Container(
              color: kSkyBlue,
              height: 2.0,
            )),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: kBlack,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(10),
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height * 0.08,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: kSkyBlue, borderRadius: BorderRadius.circular(30)),
        child: const Text(
          'Continue',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Name',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
                Row(
                  children: [
                    const Text(
                      'Peter Chan',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: kGrey,
                          borderRadius: BorderRadius.circular(30)),
                      child: const Icon(
                        Icons.edit,
                        size: 12,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            child: const Divider(
              thickness: 1.0,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Sex',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
                Row(
                  children: [
                    Radio(value: 1, groupValue: 1, onChanged: (val) {}),
                    const Text(
                      'Male',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                    Radio(value: false, groupValue: 1, onChanged: (val) {}),
                    const Text(
                      'Female',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            child: const Divider(
              thickness: 1.0,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Date of Birth',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
                Row(
                  children: [
                    const Text(
                      '01 / 01 / 1999',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: kGrey,
                          borderRadius: BorderRadius.circular(30)),
                      child: const Icon(
                        Icons.edit,
                        size: 12,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            child: const Divider(
              thickness: 1.0,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Container(
            alignment: Alignment.bottomLeft,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: const Text(
              'Address',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    //padding: const EdgeInsets.only(left: 20, right: 20),
                    //  margin: const EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.center,
                    // padding: const EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(30)),
                    height: MediaQuery.of(context).size.height * 0.037,
                    width: MediaQuery.of(context).size.width / 2.5,
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          hintText: 'Flat',
                          hintStyle: TextStyle(color: kGrey, fontSize: 10),
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 0, 20, 18),
                          border: InputBorder.none),
                    )),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
                ),
                Container(
                    //padding: const EdgeInsets.only(left: 20, right: 20),
                    //  margin: const EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.center,
                    // padding: const EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(30)),
                    height: MediaQuery.of(context).size.height * 0.037,
                    width: MediaQuery.of(context).size.width / 2.5,
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          hintText: 'Floor',
                          hintStyle: TextStyle(color: kGrey, fontSize: 10),
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 0, 20, 18),
                          border: InputBorder.none),
                    )),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 20, right: 20, top: 12),
            height: MediaQuery.of(context).size.height * 0.036,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.shade300),
            child: TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Building/House',
                  hintStyle: TextStyle(color: kGrey)),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 20, right: 20, top: 12),
            height: MediaQuery.of(context).size.height * 0.036,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.shade300),
            child: TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Estate/Street',
                  hintStyle: TextStyle(color: kGrey)),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 20, right: 20, top: 12),
            height: MediaQuery.of(context).size.height * 0.036,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.shade300),
            child: TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'District',
                  hintStyle: TextStyle(color: kGrey)),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 20, right: 20, top: 12),
            height: MediaQuery.of(context).size.height * 0.036,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.shade300),
            child: TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'city/country',
                  hintStyle: TextStyle(color: kGrey)),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
        ],
      )),
    );
  }
}
