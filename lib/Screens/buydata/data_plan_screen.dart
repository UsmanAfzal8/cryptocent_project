import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../Utils/color.dart';
import 'package:intl/intl.dart';

class DataPlanScreen extends StatefulWidget {
  const DataPlanScreen({Key? key}) : super(key: key);

  @override
  State<DataPlanScreen> createState() => _DataPlanScreenState();
}

class _DataPlanScreenState extends State<DataPlanScreen> {
  String name = 'United States';
  bool isSwitch = false;
  String selectedDate = '';
  String dateCount = '';
  String range = '';
  String rangeCount = '';

  /// called whenever a selection changed on the date picker widget.
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    /// The argument value will return the changed date as [DateTime] when the
    /// widget [SfDateRangeSelectionMode] set as single.
    ///
    /// The argument value will return the changed dates as [List<DateTime>]
    /// when the widget [SfDateRangeSelectionMode] set as multiple.
    ///
    /// The argument value will return the changed range as [PickerDateRange]
    /// when the widget [SfDateRangeSelectionMode] set as range.
    ///
    /// The argument value will return the changed ranges as
    /// [List<PickerDateRange] when the widget [SfDateRangeSelectionMode] set as
    /// multi range.
    setState(() {
      if (args.value is PickerDateRange) {
        range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
            // ignore: lines_longer_than_80_chars
            ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
        selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>) {
        dateCount = args.value.length.toString();
      } else {
        rangeCount = args.value.length.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Data Plan',
          style: TextStyle(color: kBlack),
        ),
        backgroundColor: kWhite,
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: kBlack,
            )),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage('assets/images/person.jpeg'),
                fit: BoxFit.fill,
              ),
              color: Colors.white,
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                          favorite: const ['+1', 'US'],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width / 2.3,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20), color: kGrey),
                  child: Text(
                    'DAY PLAN',
                    style: TextStyle(color: kWhite),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width / 2.3,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20), color: kSkyBlue),
                  child: Text(
                    'PAY AS YOU GO',
                    style: TextStyle(color: kWhite),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            height: MediaQuery.of(context).size.height * 0.2,
            child: ListView(scrollDirection: Axis.horizontal, children: [
              Container(
                padding: const EdgeInsets.all(6),
                width: MediaQuery.of(context).size.width / 3,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: kWhite),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 14,
                      width: 14,
                      decoration: BoxDecoration(
                          border: Border.all(color: kBlack),
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      child: Icon(
                        Icons.wifi,
                        size: 40,
                        color: kSkyBlue,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width / 3,
                          child: Text(
                            "I don't need",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: kSkyBlue),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width / 3,
                          child: Text(
                            'Data Plan',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: kSkyBlue),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.02,
              ),
              Container(
                padding: const EdgeInsets.only(left: 6, right: 6, top: 6),
                width: MediaQuery.of(context).size.width / 3,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: kWhite),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 14,
                      width: 14,
                      decoration: BoxDecoration(
                          border: Border.all(color: kBlack),
                          borderRadius: BorderRadius.circular(20),
                          color: kSkyBlue),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.wifi,
                            size: 40,
                            color: kSkyBlue,
                          ),
                          Text(
                            '1GB',
                            style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w500,
                                color: kSkyBlue),
                          )
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width / 3,
                      child: const Text(
                        '7 days',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Row(
                      //  crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          //width: MediaQuery.of(context).size.width / 6,
                          child: Text(
                            'HKD',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: kSkyBlue),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          // width: MediaQuery.of(context).size.width / 3,
                          child: Text(
                            '17.00',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: kSkyBlue),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.02,
              ),
              Container(
                padding: const EdgeInsets.only(left: 6, right: 6, top: 6),
                width: MediaQuery.of(context).size.width / 3,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: kWhite),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 14,
                      width: 14,
                      decoration: BoxDecoration(
                        border: Border.all(color: kBlack),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.wifi,
                            size: 40,
                            color: kSkyBlue,
                          ),
                          Text(
                            '5GB',
                            style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w500,
                                color: kSkyBlue),
                          )
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width / 3,
                      child: const Text(
                        '7 days',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Row(
                      //  crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          //width: MediaQuery.of(context).size.width / 6,
                          child: Text(
                            'HKD',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: kSkyBlue),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          // width: MediaQuery.of(context).size.width / 3,
                          child: Text(
                            '17.00',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: kSkyBlue),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ]),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width / 2.1,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: kWhite,
                        border: Border.all(color: kSkyBlue)),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: kSkyBlue),
                          child: Text(
                            'FROM',
                            style: TextStyle(color: kWhite, fontSize: 10),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Text(
                          '18th Nov, 2020',
                          style: TextStyle(
                              fontSize: 14,
                              color: kSkyBlue,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    )),
                Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width / 2.1,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: kWhite,
                        border: Border.all(color: kGrey)),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: kGrey),
                          child: Text(
                            'To',
                            style: TextStyle(color: kWhite, fontSize: 10),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Text(
                          '18th Nov, 2021',
                          style: TextStyle(
                              fontSize: 14,
                              color: kGrey,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    )),
              ],
            ),
          ),
          SfDateRangePicker(
            onSelectionChanged: _onSelectionChanged,
            selectionMode: DateRangePickerSelectionMode.range,
            initialSelectedRange: PickerDateRange(
                DateTime.now().subtract(const Duration(days: 4)),
                DateTime.now().add(const Duration(days: 3))),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Container(
                  // height: 30,
                  // width: 30,
                  child: CupertinoSwitch(
                    activeColor: kWhite,
                    value: isSwitch,
                    onChanged: (value) {
                      setState(() {
                        isSwitch = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.76,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Switch on the auto renew on your data plan subscription?',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.004,
                      ),
                      const Text(
                        'Your data will renew on 7 on every month',
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: kGrey,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('SUB TOTAL'),
                Text(
                  'HKD 17.00',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: kSkyBlue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Save & Next',
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w500, color: kWhite),
              )),
          SizedBox(
            height: 20,
          )
        ],
      )),
    );
  }
}
