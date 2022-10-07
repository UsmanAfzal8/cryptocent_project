import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Utils/color.dart';

class SettingScreen22 extends StatefulWidget {
  const SettingScreen22({Key? key}) : super(key: key);

  @override
  State<SettingScreen22> createState() => _SettingScreen22State();
}

class _SettingScreen22State extends State<SettingScreen22> {
  bool isEnglish = false;
  bool isArabic = false;
  bool isChinese = false;
  bool isJapanese = false;

  String countryName = 'Hong Kong, China';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhite,
        title: Text(
          'Settings',
          style: TextStyle(color: kBlack),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
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
      backgroundColor: kLightGrey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: kWhite,
              ),
              padding:
                  const EdgeInsets.only(left: 4, right: 4, top: 10, bottom: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.03,
                            ),
                            const Text(
                              'Language',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print('language====');
                          _languagePopUp(context);
                        },
                        child: Container(
                          child: Row(
                            children: [
                              Text(isEnglish == true
                                  ? 'English'
                                  : isArabic == true
                                      ? 'Arabic'
                                      : isChinese == true
                                          ? 'Chinese'
                                          : isJapanese == true
                                              ? 'Japanese'
                                              : 'English'),
                              Icon(CupertinoIcons.forward),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: const Divider()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.03,
                          ),
                          // showCountryPicker(
                          //   context: context,
                          //   showPhoneCode:
                          //       true, // optional. Shows phone code before the country name.
                          //   onSelect: (Country country) {
                          //     print('Select country: ${country.displayName}');
                          //   },
                          // ),
                          GestureDetector(
                            child: const Text(
                              'Country or Region',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                          onTap: () {
                            print('picker');
                            showCountryPicker(
                                context: context,
                                showPhoneCode:
                                    true, // optional. Shows phone code before the country name.
                                onSelect: (Country country) {
                                  setState(() {
                                    countryName = country.displayName;
                                  });
                                  print(
                                      'Select country: ${country.displayName}');
                                });
                          },
                          child: Container(
                              alignment: Alignment.topRight,
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                countryName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )))
                    ],
                  ),
                  Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: const Divider()),
                  GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: ((context) => NotificationSettings())));
                    },
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 14),
                            child: const Text(
                              'Notifications',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ),
                          const Icon(CupertinoIcons.forward)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: kWhite,
              ),
              //  margin: const EdgeInsets.only(left: 20, right: 20),
              padding:
                  const EdgeInsets.only(left: 4, right: 4, top: 10, bottom: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.03,
                          ),
                          const Text(
                            'Terms and Conditions',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const Icon(CupertinoIcons.forward)
                    ],
                  ),
                  Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: const Divider()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.03,
                          ),
                          const Text(
                            'Privacy Policy',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const Icon(CupertinoIcons.forward)
                    ],
                  ),
                  Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: const Divider()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.03,
                          ),
                          const Text(
                            'Contact Us',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const Icon(CupertinoIcons.forward)
                    ],
                  ),
                  Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      child: const Divider()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.03,
                          ),
                          const Text(
                            'FAQ',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const Icon(CupertinoIcons.forward)
                    ],
                  ),
                  Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: const Divider()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.03,
                          ),
                          const Text(
                            'Version',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const Text('1.00.18')
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _languagePopUp(BuildContext context) {
    return showDialog(
        context: context,
        builder: (_) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.center,
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height * 0.34,
                  child: Column(
                    children: [
                      Text(
                        'Select your preferred language',
                        style: TextStyle(
                            color: kSkyBlue,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      GestureDetector(
                          onTap: () {
                            print('china');
                            setState(() {
                              print('china========');

                              isArabic = false;
                              isChinese = true;
                              isJapanese = false;
                              isEnglish = false;
                            });
                            Navigator.pop(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Chinese',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w400),
                              ),
                              Icon(Icons.arrow_forward_ios),
                            ],
                          )),
                      Divider(),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      GestureDetector(
                          onTap: () {
                            print('japan');
                            setState(() {
                              print('japan========');

                              isArabic = false;
                              isChinese = false;
                              isJapanese = true;
                              isEnglish = false;
                            });
                            Navigator.pop(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Japanese',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w400),
                              ),
                              Icon(Icons.arrow_forward_ios),
                            ],
                          )),
                      Divider(),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      GestureDetector(
                          onTap: () {
                            print('arabic');

                            setState(() {
                              print('arabic======');
                              isEnglish = false;
                              isChinese = false;
                              isJapanese = false;
                              isArabic = true;
                            });
                            Navigator.pop(context);
                          },
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Arabic',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                                Icon(Icons.arrow_forward_ios),
                              ],
                            ),
                          )),
                      Divider(),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      GestureDetector(
                          onTap: () {
                            print('english');

                            setState(() {
                              print('english=========');

                              isArabic = false;
                              isChinese = false;
                              isJapanese = false;
                              isEnglish = true;
                            });
                            Navigator.pop(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'English',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w400),
                              ),
                              Icon(Icons.arrow_forward_ios),
                            ],
                          )),
                    ],
                  )),
            ),
          );
        });
  }
}
