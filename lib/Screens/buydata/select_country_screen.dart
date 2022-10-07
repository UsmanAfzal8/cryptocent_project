import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import '../../Utils/color.dart';
import '../../widgets/bootom_navigation_bar.dart';

class SelectCountryScreen extends StatefulWidget {
  const SelectCountryScreen({Key? key}) : super(key: key);

  @override
  State<SelectCountryScreen> createState() => _SelectCountryScreenState();
}

class _SelectCountryScreenState extends State<SelectCountryScreen> {
  String? dropDownValue;
  String name = 'Select Country';
  @override
  Widget build(BuildContext context) {
    return ContentWithBottomNavigationBar(
      appbarTitle: 'Buy Data and Call Plan',
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage('assets/images/mob.jpeg'),
                fit: BoxFit.fill,
              ),
              color: Colors.white,
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'STAY CONNECTED LOCALLY\nWITH CONTRACT FREEDOM',
                  style: TextStyle(color: kWhite, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Container(
                  margin: const EdgeInsets.all(16),
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: kSkyBlue),
                    borderRadius: BorderRadius.circular(30),
                    color: kWhite,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin:
                            const EdgeInsets.only(top: 14, left: 10, right: 10),
                        child: Text(
                          name,
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomCenter,
                        child: CountryCodePicker(
                          onChanged: (value) {
                            setState(() {
                              name = value.name!;
                            });
                          },
                          hideSearch: true,
                          initialSelection: '+1',
                          showCountryOnly: false,
                          showDropDownButton: true,
                          showOnlyCountryWhenClosed: true,
                          showFlag: false,
                          hideMainText: true,
                          showFlagDialog: true,
                          favorite: ['+1', 'US'],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.7,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: kSkyBlue,
                  ),
                  child: Text(
                    'Explore Now',
                    style: TextStyle(color: kWhite),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2.6,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: ExactAssetImage('assets/images/building.jpeg'),
                fit: BoxFit.fill,
              ),
              color: kSkyBlue,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'STAY CONNECTED LOCALLY\nWITH CONTRACT FREEDOM',
                  style: TextStyle(color: kWhite, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.7,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: kSkyBlue,
                  ),
                  child: Text(
                    'Explore Now',
                    style: TextStyle(color: kWhite),
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
