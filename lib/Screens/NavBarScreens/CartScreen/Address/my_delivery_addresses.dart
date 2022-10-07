import 'package:crypto_cent/Models/view_address_model.dart';
import 'package:crypto_cent/Utils/color.dart';
import 'package:crypto_cent/Utils/url.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'place_order_screen.dart';

class MyDeliveryAddress extends StatefulWidget {
  const MyDeliveryAddress({Key? key}) : super(key: key);

  @override
  State<MyDeliveryAddress> createState() => _MyDeliveryAddressState();
}

class _MyDeliveryAddressState extends State<MyDeliveryAddress> {
  List<ViewAddressModel> _viewAddress = [];
  var id;
  var userId;
  bool mainLoader = true;
  bool loader = true;

  callViewAddressApi(String token, String id) async {
    http.Response response = await http.get(Uri.parse(viewAddressUrl + id),
        headers: {'Authorization': 'Bearer $token'});
    Map jsonData = jsonDecode(response.body);
    print("jsonData ${jsonData.toString()}");
    print('viewAddressUrl: ${viewAddressUrl+id}');

    if (jsonData['status'] == 'Address not found!') {
      print('Address not found!');
      print('error 404');
      setState(() {
        mainLoader = false;
        loader = true;
      });
    } else if (response.statusCode == 200) {
      print('viewAddressUrl: ${viewAddressUrl+id}');
      print('statusCode: ${response.statusCode}');
      for (int i = 0; i < jsonData['data'].length; i++) {
        Map<String, dynamic> obj = jsonData['data'][i];
        var pos = ViewAddressModel();
        pos = ViewAddressModel.fromJson(obj);
        _viewAddress.add(pos);
      }
      setState(() {
        mainLoader = false;
        loader = false;
      });
    } else {
      print('else');
      setState(() {
        mainLoader = false;
        loader = true;
      });
    }
  }

  getSharedPreference() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    id = sharedPreferences.getString('userToken');
    userId = sharedPreferences.getString('userId');

    print('token==$id');
    print('id==$userId');
    callViewAddressApi(id, userId);
  }

  @override
  void initState() {
    super.initState();
    getSharedPreference();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Delivery Address',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
            ),
            centerTitle: true,
            iconTheme: IconThemeData(color: kBlack),
            backgroundColor: kWhite,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: mainLoader ? Center(child: CircularProgressIndicator()) :
          SingleChildScrollView(
              child: Column(
                children: [
                  loader ? Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: Center(
                      child: Text('No delivery address found!',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ) : deliveryAddress()
                ],
            )),
    ));
  }

  Widget deliveryAddress() {
    return ListView.builder(
        itemCount: _viewAddress.length,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => PlaceOrderScreen(
                    myName: _viewAddress[index].name,
                    myPhone: _viewAddress[index].phone,
                    myAddress: _viewAddress[index].address,
                    myCity: _viewAddress[index].city,
                    myState: _viewAddress[index].state,
                    myZipCode: _viewAddress[index].zipCode,

                  )));
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.03,
                  right: MediaQuery.of(context).size.width * 0.03,
                  top: MediaQuery.of(context).size.height * 0.01),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: primarycolor)
                // boxShadow: [BoxShadow(color: primarycolor, blurRadius: 1.0)],
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade200),
                    child: Icon(CupertinoIcons.location, color: primarycolor, size: 24),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      _viewAddress[index].address.toString() +
                          ' ' +
                          _viewAddress[index].zipCode.toString() +
                          ' ' +
                          _viewAddress[index].city.toString(),
                      style: TextStyle(color: Colors.black,
                          fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
