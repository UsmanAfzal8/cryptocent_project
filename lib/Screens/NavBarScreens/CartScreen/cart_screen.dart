import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Utils/color.dart';
import '../../../Utils/url.dart';
import '../../../widgets/toast_message.dart';
import '../../Authentication/SignUp/signup_screen.dart';
import 'Address/my_delivery_addresses.dart';
import 'cart_model_list.dart';

class CartScreen extends StatefulWidget {

  const CartScreen({Key? key,}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  int? sum;
  bool isLoadAllProduct = false;
  int discountAmount = 10;
  double _subTotal = 0.0;
  double totalAmount = 0.0;
  double grandTotal = 0.0;
  List<String> productIds = [];
  int? jsonId;


  subTotalAmount() {
    _subTotal = 0;
    setState(() {});
    print("myClicked");
    for (int i = 0; i < cartItems.length; i++) {
      print("total = ${_subTotal.toString()}");
      print("qty = ${cartItems[i].itemCount}");
        _subTotal = _subTotal + (double.parse(cartItems[i].productPrice) * cartItems[i].itemCount.toDouble());
      print("totalAmount1 ${_subTotal.toString()}");
    }
    setState(() {
      totalAmount = _subTotal;
      print("totalAmount2 ${_subTotal.toString()}");
    });

    isLoadAllProduct = false;
    setState(() {});
    getTotal();
  }

  getTotal() {
    _subTotal = 0;
    setState(() {});
    print("myClicked");
    for (int i = 0; i < cartItems.length; i++) {
      _subTotal = _subTotal + (double.parse(cartItems[i].productPrice) * cartItems[i].itemCount.toDouble());
    }

    setState(() {
      grandTotal = _subTotal - discountAmount;
      print("grandAmount1 ${_subTotal.toString()}");
      print("grandAmount1 ${grandTotal.toString()}");
    });

    isLoadAllProduct = false;
    setState(() {});
  }

  selectedProductId(){
    productIds.clear();
    for(int i = 0; i<cartItems.length; i++){
      productIds.add(cartItems[i].id);
    }
    print('this is the productId ${productIds.toString()}');
    // jsonId = jsonEncode(int.parse(productIds.toString()));
    // print('this is the ids $jsonId');
  }

  getSharedPreference() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userToken = sharedPreferences.getString('userToken');
    userId = sharedPreferences.getString('userId');

    print('token==$userToken');
    print('id==$userId');

    subTotalAmount();
  }
  @override
  void initState() {
    super.initState();
    getSharedPreference();
  }

  double perItemTotal(double p, double q) {
    double cal = p * q;
    return cal;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        appBar: AppBar(
          title: Text("My CartScreen", style: TextStyle(color: kBlack),),
          centerTitle: true,
          backgroundColor: kWhite,
          iconTheme: IconThemeData(color: kBlack),
          automaticallyImplyLeading: false,
          elevation: 2,
          leading: GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: const Icon(Icons.menu)),
        ),
        // backgroundColor: kWhite,
        backgroundColor: Colors.grey.shade50,
        bottomNavigationBar: GestureDetector(
          child: Container(
            color: Colors.grey.shade100,
            height: MediaQuery.of(context).size.height * 0.21,
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Select Item'),
                      Text(cartItems.length.toString()),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Price'),
                      Text('\$ ${totalAmount}'),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Discount '),
                      Text("\$ ${discountAmount.toString()}"),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Price'),
                     cartItems.length< 1? Text("0"):  Text('\$ ${grandTotal}'),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                GestureDetector(
                  onTap: () async {
                    selectedProductId();
                    if(cartItems.isEmpty){
                      toastMessage("cart is empty", Colors.red);
                    }
                    else{
                      print("checkOut clicked");
                      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                      sharedPreferences.setString('sub_total', _subTotal.toString());
                      sharedPreferences.setString('grand_total', grandTotal.toString());
                      sharedPreferences.setString('discount_amount', discountAmount.toString());
                      sharedPreferences.setString('product_id_list', productIds.toString());
                      print("subTotal ${_subTotal}");
                      print("grandTotal $grandTotal");
                      print("discount ${discountAmount}");
                      print("productIds ${productIds.toString()}");

                      // Navigator.push(context, MaterialPageRoute(
                      //     builder: (context) => PlaceOrderScreen(
                      //       subTotalAmount: _subTotal,
                      //       grandTotal: grandTotal,
                      //       discountAmount: discountAmount,
                      //       productIds: productIds.toString(),
                      //     )));
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => MyDeliveryAddress()));
                      print("proIds: ${productIds.toString()}");
                    }
                    // else{
                    //   await checkOutWidget();
                    //   toastMessage("checkout successfully", Colors.green);
                    //
                    // }
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: primarycolor,
                        borderRadius: BorderRadius.circular(30)),
                    child: Text('Checkout',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500, color: kWhite),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: isLoadAllProduct == true ? Center(child: CircularProgressIndicator(),) :
        cartItems.length < 1 ? Center(child: Text('No data found In Cart...',
            style: TextStyle(fontWeight: FontWeight.bold),),
        ):
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.62,
                color: Colors.transparent,
                child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index){
                  return  GestureDetector(
                    onPanUpdate: (details) {
                      // Swiping in right direction.
                      if (details.delta.dx > 0) {
                        print('hello right');
                      }

                      // Swiping in left direction.
                      if (details.delta.dx < 0) {
                        print('hello left');
                      }
                    },
                    child: Slidable(
                      endActionPane: ActionPane(
                        motion: ScrollMotion(),
                        children: [
                          SlidableAction(
                            flex: 1,
                            onPressed: null,
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.red,
                            label: 'Remove',
                          ),
                        ],
                      ),
                      child: Card(
                        color: kWhite,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Container(
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.02,
                              right: MediaQuery.of(context).size.width * 0.02,
                              top: MediaQuery.of(context).size.width * 0.01,

                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${cartItems[index].productName}',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                                  SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                                  Container(
                                    width: MediaQuery.of(context).size.width / 2,
                                    child: Row(
                                      children: [
                                        Container(
                                          // color: Colors.red,
                                          width: MediaQuery.of(context).size.width * 0.3,
                                          child: Text('${cartItems[index].productReview} reviews',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(color: Colors.grey),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                                  // Text('\$ ${widget.itemPrice}',
                                  Text("${cartItems[index].productPrice} * ${cartItems[index].itemCount} = ${perItemTotal(double.parse(cartItems[index].productPrice), cartItems[index].itemCount.toDouble())}",
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: (){
                                          setState((){
                                            cartItems[index].itemCount--;
                                            sum = int.parse(cartItems[index].productPrice) * cartItems[index].itemCount;
                                            print("totalPriceDeduct: $sum");
                                            subTotalAmount();
                                            if(cartItems[index].itemCount == 0)
                                              cartItems.removeAt(index);
                                          });
                                        },
                                        child:  CircleAvatar(
                                          radius: 17,
                                          backgroundColor: Colors.red,
                                          child: Icon(Icons.remove, color: kWhite,),
                                        ),
                                      ),

                                      SizedBox(width: MediaQuery.of(context).size.width * 0.02,),

                                      CircleAvatar(
                                          radius: 17,
                                          backgroundColor: Colors.grey.shade300,
                                          child: Text(cartItems[index].itemCount.toString(), style: TextStyle(color: Colors.black, fontSize: 20),)
                                      ),

                                      SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
                                      GestureDetector(
                                        onTap: (){
                                          setState((){
                                            cartItems[index].itemCount++;
                                            sum = int.parse(cartItems[index].productPrice) * cartItems[index].itemCount;
                                            print("totalPricePlus: $sum");
                                           subTotalAmount();
                                          });
                                        },
                                        child: CircleAvatar(
                                          radius: 17,
                                          backgroundColor: Colors.green,
                                          child: Icon(Icons.add, color: kWhite,),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                                ],
                              ),

                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: cyanColor),
                                padding: const EdgeInsets.all(8),
                                child: Image.network(
                                  productBaseUrl + cartItems[index].productImage.toString(),
                                  fit: BoxFit.fill,
                                  height: MediaQuery.of(context).size.height * 0.1,
                                  width: MediaQuery.of(context).size.width * 0.25 ,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
            ],
          ),
        ),
      ),
    );
  }
}
