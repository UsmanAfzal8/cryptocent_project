import 'package:flutter/material.dart';
import '../../Utils/color.dart';

class ConfirmationScreen extends StatefulWidget {
  const ConfirmationScreen({Key? key}) : super(key: key);

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhite,
        title: Text(
          'User Registration',
          style: TextStyle(color: kBlack),
        ),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(4.0),
            child: Container(
              color: kSkyBlue,
              height: 2.0,
            )),
        centerTitle: true,
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
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.88,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kWhite,
                      boxShadow: [BoxShadow(color: kGrey, blurRadius: 4.0)]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Name on ID Card/Passport',
                        style: TextStyle(
                            color: kSkyBlue,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        'Peter Chan',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: kBlack),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      Text(
                        'Sex',
                        style: TextStyle(
                            color: kSkyBlue,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        'Male',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: kBlack),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      Text(
                        'Date of Birth',
                        style: TextStyle(
                            color: kSkyBlue,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '01/ 01/ 1999',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: kBlack),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      Text(
                        'Address',
                        style: TextStyle(
                            color: kSkyBlue,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              width: MediaQuery.of(context).size.width / 3,
                              child: Text(
                                'Flat',
                                style: TextStyle(
                                    color: kGrey,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 3,
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Room 503',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: kBlack),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              width: MediaQuery.of(context).size.width / 3,
                              child: Text(
                                'Floor',
                                style: TextStyle(
                                    color: kGrey,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              width: MediaQuery.of(context).size.width / 3,
                              child: Text(
                                '5F',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: kBlack),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              width: MediaQuery.of(context).size.width / 2.8,
                              child: Text(
                                'Building/House',
                                style: TextStyle(
                                    color: kGrey,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              width: MediaQuery.of(context).size.width / 3,
                              child: Text(
                                'DEF Building',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: kBlack),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              width: MediaQuery.of(context).size.width / 2.8,
                              child: Text(
                                'Estate/Street',
                                style: TextStyle(
                                    color: kGrey,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              width: MediaQuery.of(context).size.width / 3,
                              child: Text(
                                'Kwun Tong',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: kBlack),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              width: MediaQuery.of(context).size.width / 2.8,
                              child: Text(
                                'District',
                                style: TextStyle(
                                    color: kGrey,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              width: MediaQuery.of(context).size.width / 3,
                              child: Text(
                                'Kowloon',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: kBlack),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              width: MediaQuery.of(context).size.width / 2.8,
                              child: Text(
                                'City/Country',
                                style: TextStyle(
                                    color: kGrey,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              width: MediaQuery.of(context).size.width / 3,
                              child: Text(
                                'Hong Kong',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: kBlack),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      const Text(
                          'Make sure that all your information is correct'),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: kSkyBlue),
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          'Confirm',
                          style: TextStyle(
                              color: kWhite,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      )),
    );
  }
}
