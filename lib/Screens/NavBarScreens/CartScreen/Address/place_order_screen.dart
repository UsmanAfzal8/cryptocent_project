import 'package:crypto_cent/Utils/color.dart';
import 'package:crypto_cent/Utils/url.dart';
import 'package:crypto_cent/widgets/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../../Models/checkout_model.dart';
import '../../../Authentication/SignUp/signup_screen.dart';
import '../../nav_bar_screen.dart';
import '../cart_model_list.dart';

class PlaceOrderScreen extends StatefulWidget {
  final String? myName, myPhone, myAddress, myCity, myState, myZipCode;

 PlaceOrderScreen({Key? key, this.myName, this.myPhone, this.myAddress, this.myCity, this.myState, this.myZipCode
 }) : super(key: key);

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  final GlobalKey<FormState> formKeyPlaceOrder = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var zipCodeController = TextEditingController();
  CheckOutModel? checkOutModelObject;

  bool isLoadAllProduct = false;
  bool mainLoader = true;
  bool loader = true;
  var userToken;

  var mySubTotal, myGrandTotal, myDiscount, myProductIds;
  getSharedPreference() async {
    setState(() {
      mainLoader = true;
    });
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userToken = sharedPreferences.getString('userToken');
    userId = sharedPreferences.getString('userId');

    mySubTotal = sharedPreferences.getString('sub_total');
    myGrandTotal = sharedPreferences.getString('grand_total');
    myDiscount = sharedPreferences.getString('discount_amount');
    myProductIds = sharedPreferences.getString('product_id_list');
    print('mySubTotal: ${mySubTotal}');
    print('myGrandTotal: ${myGrandTotal}');
    print('mySubYTotal: ${myDiscount}');
    print('mySubYTotal: ${myProductIds}');

    print('token==$userToken');
    print('id==$userId');

    setState(() {
      mainLoader = false;
    });
    setData();
  }

  placeOrderWidget() async {
    isLoadAllProduct = true;
    setState(() {});
    try {
      String apiUrl = checkOutApiUrl;
      print("checkOutApi: $apiUrl");
      print("quantity: ${cartItems.length}");
      print("gross_total: ${mySubTotal}");
      print("discount: ${myDiscount}");
      print("net_total: ${myGrandTotal}");
      print("user_id: $userId");
      print("product_id: ${myProductIds}");
      print("userName: ${nameController.text}");
      print("userNumber: ${phoneController.text}");
      print("userAddress: ${addressController.text}");
      print("userCity: ${cityController.text}");
      print("userState: ${stateController.text}");
      print("userZipCode: ${zipCodeController.text}");
      final response = await http.post(
          Uri.parse(apiUrl),
          body: {
            "quantity": cartItems.length.toString(),
            "gross_total": mySubTotal.toString(),
            "discount": myDiscount.toString(),
            "net_total": myGrandTotal.toString(),
            "user_id": userId.toString(),
            "product_id": myProductIds.toString(),
          },
          headers:{
            'Authorization': 'Bearer $userToken',
            'Accept': 'application/json'
          }
      );

      final responseString = response.body;
      print('response'+responseString);
      print("status Code: ${response.statusCode}");
      if (response.statusCode == 200) {
        print("in 200");
        checkOutModelObject = checkOutModelFromJson(responseString);
      }
    }
    catch (e) {
      print('checkOut error in catch = ${e.toString()}');
    }
    setState(() {
      isLoadAllProduct = false;
    });
  }

  setData() {
    nameController.text = widget.myName.toString();
    phoneController.text = widget.myPhone.toString();
    addressController.text = widget.myAddress.toString();
    cityController.text = widget.myCity.toString();
    stateController.text = widget.myState.toString();
    zipCodeController.text = widget.myZipCode.toString();
  }

  @override
  void initState() {
    super.initState();
    getSharedPreference();
    print("myName: ${widget.myName}");
    print("myName: ${widget.myPhone}");
    print("myName: ${widget.myAddress}");
    print("myName: ${widget.myCity}");
    print("myName: ${widget.myState}");
    print("myName: ${widget.myZipCode}");

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kWhite,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          iconTheme: IconThemeData(color: kBlack),
          centerTitle: true,
          title: Text(
            'Delivery Address',
            style: TextStyle(fontSize: 20, color: kBlack),
          )),
      body: SingleChildScrollView(
          child: Column(
        children: [

          buildPlaceOrderTextFields(),

          GestureDetector(
            onTap: () async {
             if(formKeyPlaceOrder.currentState!.validate()){
               await placeOrderWidget().then((value){
                 toastMessage('Order placed successfully', Colors.green);
                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NavBarScreen()));
                 setState(() {
                   cartItems.clear();
                 });
               });

             }
            },
            child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    color: primarycolor,
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(40)),
                child: isLoadAllProduct == true
                    ? CircularProgressIndicator()
                    : Text('Place Order',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                )),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        ],
      )),
    );
  }

  Widget buildPlaceOrderTextFields() {
    return Padding(
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.05,
            right: MediaQuery.of(context).size.width * 0.05,
            bottom: MediaQuery.of(context).size.height * 0.1,
            top: MediaQuery.of(context).size.height * 0.04,
        ),
        child: Form(
          key: formKeyPlaceOrder,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05,
                    right: MediaQuery.of(context).size.width * 0.05,
                ),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '${widget.myName}',
                    labelText: 'Full Name',
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Name is Required';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
              Container(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05,
                  right: MediaQuery.of(context).size.width * 0.05,
                ),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '${widget.myPhone}',
                    labelText: 'Phone Number',
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Phone Number is Required';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
              Container(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05,
                  right: MediaQuery.of(context).size.width * 0.05,
                ),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  controller: addressController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '${widget.myAddress}',
                    labelText: 'Address',
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Address is Required';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
              Container(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05,
                  right: MediaQuery.of(context).size.width * 0.05,
                ),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  controller: cityController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '${widget.myCity}',
                    labelText: 'City',
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'City is Required';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
              Container(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05,
                  right: MediaQuery.of(context).size.width * 0.05,
                ),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  controller: stateController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '${widget.myState}',
                    labelText: 'State',
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'State is Required';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
              Container(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05,
                  right: MediaQuery.of(context).size.width * 0.05,
                ),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  controller: zipCodeController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '${widget.myZipCode}',
                    labelText: 'Zip code',
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'ZipCode is Required';
                    }
                    return null;
                  },
                ),
              ),
              // SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
            ],
          ),
        ));
  }

}
