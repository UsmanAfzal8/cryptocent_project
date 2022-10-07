import 'package:crypto_cent/Utils/color.dart';
import 'package:crypto_cent/Utils/url.dart';
import 'package:flutter/material.dart';
import '../CartScreen/ad_to_cart_model.dart';
import '../CartScreen/cart_model_list.dart';

class ProductDetailScreen extends StatefulWidget {
  final String? productId,
      productTitle,
      productDescription,
      productImage,
      productPrice,
      productReviews;

  ProductDetailScreen(
      {Key? key,
      this.productId,
      this.productTitle,
      this.productDescription,
      this.productImage,
      this.productPrice,
      this.productReviews})
      : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool checkCart = false;

  @override
  void initState() {
    super.initState();
    print("this is productId: ${widget.productId}");
    print("this is title: ${widget.productTitle}");
  }

  bool pressed = false;

  List<String> myItemList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.productTitle}',
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  productBaseUrl + widget.productImage!.toString(),
                  fit: BoxFit.fill,
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Text(
                    '${widget.productTitle}',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${widget.productReviews} Reviews',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        '\$ ${widget.productPrice}',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: const Text(
                    'About',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    "${widget.productDescription}",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                GestureDetector(
                    onTap: () {
                      if (cartContains(widget.productId!)) return;

                      print('hello');
                      print('total length of cart item ${cartItems.length}');
                      if (cartItems.length == 0) {
                        cartItems.add(CartModel(
                            widget.productId!,
                            widget.productTitle!,
                            widget.productDescription!,
                            widget.productImage!,
                            widget.productReviews!,
                            widget.productPrice!));
                        print('cart ItemLength ${cartItems.length}');
                        // toastMessage("Item Added to Cart", Colors.green);
                        setState(() {
                          checkCart = true;
                        });
                      } else {
                        for (int i = 0; i < cartItems.length; i++) {
                          print('hello2');
                          print('cart ItemId ${widget.productId}');
                          print('cart ItemId ${cartItems[i].id}');

                          if (widget.productId != cartItems[i].id) {
                            cartItems.add(CartModel(
                                widget.productId!,
                                widget.productTitle!,
                                widget.productDescription!,
                                widget.productImage!,
                                widget.productReviews!,
                                widget.productPrice!));
                            print('cart ItemLength ${cartItems.length}');
                            // toastMessage("Item Added to Cart1", Colors.green);
                            print('Item Added to Cart');
                            setState(() {
                              checkCart = true;
                            });
                          } return ;

                          // else  {
                          //   // toastMessage("already Added to Cart1", Colors.red);
                          //   print('already added');
                          //   print('cart ItemLength Already Added ${cartItems.length}');
                          //   setState(() {
                          //     checkCart = false;
                          //   });
                          //   print('hello4');
                          // }
                        }
                      }
                      print('hello5');
                    },
                    child: cartContains(widget.productId!)
                        ? Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(left: 20, right: 20),
                            child: Text('Added to cart',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: kWhite),
                            ),
                          )
                        : Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: primarycolor,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(left: 20, right: 20),
                            child: Text('Add to cart',
                              style: TextStyle(fontSize: 20,
                                  fontWeight: FontWeight.w500, color: kWhite),),
                          )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
