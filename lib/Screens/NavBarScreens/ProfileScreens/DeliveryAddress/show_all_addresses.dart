import 'package:crypto_cent/Models/view_address_model.dart';
import 'package:crypto_cent/Utils/color.dart';
import 'package:crypto_cent/Utils/url.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Setting/edit_address.dart';
import 'add_delivery_address_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ShowAllAddress extends StatefulWidget {
  const ShowAllAddress({Key? key}) : super(key: key);

  @override
  State<ShowAllAddress> createState() => _ShowAllAddressState();
}

class _ShowAllAddressState extends State<ShowAllAddress> {
  List<ViewAddressModel> _viewAddress = [];
  var id;
  var userId;
  bool mainLoader = true;
  bool loader = true;

  callViewAddressApi(String token, String id) async {
    http.Response response = await http.get(Uri.parse(viewAddressUrl + id),
        headers: {'Authorization': 'Bearer $token'});
    Map jsonData = jsonDecode(response.body);
    print(jsonData.toString());

    if (jsonData['status'] == 'Address not found!') {
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

  var mySubTotal, myGrandTotal, myDiscount, myProductIds;
  getSharedPreference() async {
    setState(() {
      loader = true;
    });
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    id = sharedPreferences.getString('userToken');
    userId = sharedPreferences.getString('userId');

    mySubTotal = sharedPreferences.getString('sub_total');
    myGrandTotal = sharedPreferences.getString('grand_total');
    myDiscount = sharedPreferences.getString('discount_amount');
    myProductIds = sharedPreferences.getString('product_id_list');
    print('mySubTotal: ${mySubTotal}');
    print('myGrandTotal: ${myGrandTotal}');
    print('mySubYTotal: ${myDiscount}');
    print('mySubYTotal: ${myProductIds}');

    print('token==$id');
    print('id==$userId');

    setState(() {
      loader = false;
    });

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
      backgroundColor: kWhite,
      bottomNavigationBar: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
                  builder: (context) => AddDeliveryAddressScreen()));
        },
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
          height: MediaQuery.of(context).size.height * 0.07,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: primarycolor),
          child: Text(
            'Add New Address',
            style: TextStyle(color: kWhite, fontSize: 18),
          ),
        ),
      ),
      body: mainLoader ? Center(child: CircularProgressIndicator(),)
          : SingleChildScrollView(
              child: Column(
              children: [
                // SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                loader
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: Center(
                          child: Text(
                            'No delivery address found!',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      )
                    : deliveryAddress()
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
            onTap: (){
              // Navigator.push(context, MaterialPageRoute(builder: (context) => EditAddressScreen()));
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => EditAddressScreen(
                    myName: _viewAddress[index].name,
                    myPhone: _viewAddress[index].phone,
                    myAddress: _viewAddress[index].address,
                    myCity: _viewAddress[index].city,
                    myState: _viewAddress[index].state,
                    myZipCode: _viewAddress[index].zipCode,
                  )));
              print("myData: ${_viewAddress[index].name} ${_viewAddress[index].phone} ${_viewAddress[index].address} ${_viewAddress[index].city} ${_viewAddress[index].state} ${_viewAddress[index].zipCode} ");

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
                    child: Icon(CupertinoIcons.location, color: primarycolor, size: 24,),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.03,),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      _viewAddress[index].address.toString() +
                          ' ' +
                          _viewAddress[index].zipCode.toString() +
                          ' ' +
                          _viewAddress[index].city.toString(),
                      style: TextStyle(
                          color: Colors.black, fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
