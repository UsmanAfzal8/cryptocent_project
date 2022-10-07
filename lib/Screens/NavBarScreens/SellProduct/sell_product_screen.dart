import 'dart:convert';
import 'dart:io';
import 'package:crypto_cent/Utils/url.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart'as http;
import 'package:multi_image_picker/multi_image_picker.dart';
import '../../../Models/product_upload_model.dart';
import '../../../Utils/color.dart';
import '../../../widgets/toast_message.dart';
import '../../Authentication/SignUp/signup_screen.dart';

class SellProductScreen extends StatefulWidget {
  const SellProductScreen({Key? key}) : super(key: key);

  @override
  State<SellProductScreen> createState() => _SellProductScreenState();
}

class _SellProductScreenState extends State<SellProductScreen> {
  String? dropDownValue;
  bool isBuyNowPrice = false;
  bool isAuction = false;
  bool myLoader = false;

  List<Asset> selectedImages = <Asset>[];
  List<File> myImages = [];

  final picker = ImagePicker();

  File? image;
  pickImage() async {
    try{
      final img = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(img == null)
        return ;
      final imagePick = File(img.path);

      setState(() {
        image = imagePick;
        myImages.add(imagePick);
        print("adjjdjfddf $imagePick");
        print("adjjdjfdd ${myImages.length}");
      });
    }
    catch (e) {
    }
  }



  Future<void> pickImagesFormGallery() async {
    List<Asset> resultList = <Asset>[];
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 20,
        enableCamera: true,
        selectedAssets: selectedImages,
        materialOptions: const MaterialOptions(
          actionBarTitle: "max 20 images can be selected",
        ),
      );
    } on Exception catch (e) {
      print(e);
    }
    setState(() {
      selectedImages = resultList;
      print("Image List Length:" + selectedImages.length.toString());
    });
  }

  ProductUploadModel? productUploadModelObject;
  var productNameController = TextEditingController();
  var productDescriptionController = TextEditingController();
  var productPriceControllerBuyNow = TextEditingController();
  var localDeliveryPriceControllerBuyNow = TextEditingController();
  var internationalDeliveryPriceControllerBuyNow = TextEditingController();
  var startingPriceControllerAuction = TextEditingController();
  var localDeliveryPriceControllerAuction = TextEditingController();
  var internationalDeliveryPriceControllerAuction = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyBuyNow = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyAuction = GlobalKey<FormState>();

  bool loading = true;
  productUploadWidget() async {
    loading = true;
    setState(() {});
    // try {
    String apiUrl = "$sellProductApiUrl";
    print("productUploadApi: $apiUrl");
    print("sale_type: ${isBuyNowPrice? 1 : 2}");
    print("acution_days: ${isAuction? dropDownValue : "1"}");
    print("title: ${productNameController.text}");
    print("description: ${productDescriptionController.text}");
    print("price: ${isBuyNowPrice? productPriceControllerBuyNow.text: startingPriceControllerAuction.text}");
    print("shipping: ${isBuyNowPrice? localDeliveryPriceControllerBuyNow.text : localDeliveryPriceControllerAuction.text}");
    print("international_shipping: ${isBuyNowPrice? internationalDeliveryPriceControllerBuyNow.text : internationalDeliveryPriceControllerAuction.text}");
    print('productImages: ${myImages[0].path.split('/').last}');
    final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          "category_id": "1",
          "title": productNameController.text,
          "description": productDescriptionController.text,
          "price": isBuyNowPrice? productPriceControllerBuyNow.text: startingPriceControllerAuction.text,
          "sale_type": isBuyNowPrice? "1" : "2",
          "shipping": isBuyNowPrice? localDeliveryPriceControllerBuyNow.text : localDeliveryPriceControllerAuction.text,
          "international_shipping": isBuyNowPrice? internationalDeliveryPriceControllerBuyNow.text : internationalDeliveryPriceControllerAuction.text,
          "productimage[]": myImages[0].path.split('/').last,
          "acution_days": isAuction? dropDownValue : "",
          "user_id": userId,
          "sub_category_id": "10",
        },
        headers:{
          'Authorization': 'Bearer $userToken',
          // 'Content-type': 'application/json'
        }
    );

    final responseString = response.body;
    print('response'+responseString);
    print("status Code: ${response.statusCode}");
    if (response.statusCode == 200) {
      print("in 200");
      productUploadModelObject = productUploadModelFromJson(responseString);
    }
    // }
    // catch (e) {
    //   print('productUpload error in catch = ${e.toString()}');
    //   return null;
    // }
    loading = false;
    setState(() {});
  }

  List<dynamic> imagesListArray = <dynamic>[];
  imagesList() {
    imagesListArray.clear();
    for (int i = 0; i < selectedImages.length; i++) {
      imagesListArray.add(selectedImages[i].identifier);
      print("selectedIndex: ${selectedImages[i].identifier}");
    }
    String jsonImages = jsonEncode(imagesListArray.toString());
    print('jsonImages: $jsonImages');
    print("imagesLength: ${imagesListArray}");
  }

  @override
  Widget build(BuildContext context) {
    print(" asdfghjll $image");
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Add Product", style: TextStyle(color: kBlack),),
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
          backgroundColor: kWhite,
          body: SingleChildScrollView(
            child: Column(
              children: [
                ElevatedButton(
                onPressed: () {
                  pickImage();
                  // createBottomSheet(context);
                },
                child: const Text('Add Image'),
              ),

                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: Colors.grey.shade100),
                  child:
                  // selectedImages.length < 1 ? Padding(
                  //   padding: const EdgeInsets.only(right:10.0),
                  //   child: InkWell(
                  //     onTap: () async {
                  //       showPopUpForImagePicker(context);
                  //       setState(() {
                  //       });
                  //       print("Clicked");
                  //     },
                  //     child: Icon(Icons.cloud_upload_outlined, size: 40,),
                  //   ),
                  // ):
                  ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: myImages.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 2),
                            child : Stack(
                              children: [
                                Image.file(myImages[index], fit: BoxFit.fill, height: 150, width: 130,),
                                // AssetThumb(
                                //   asset: selectedImages[index],
                                //   width: 130, height: 155,
                                // ),
                                Positioned(
                                    right: 02,
                                    child: GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          selectedImages.removeAt(index);
                                        });
                                        },
                                      child: const Icon(Icons.delete, color: Colors.red, size: 30,),
                              )),
                              ],
                            )
                        );
                      }
                      ),
          ),

                // SizedBox(width: 10,),
                // GestureDetector(
                //    onTap: () async {
                //      showPopUpForImagePicker(context);
                //      setState(() {
                //      });
                //    },
                //    child: Icon(Icons.cloud_upload_outlined, size: 40,)),

          SizedBox(height: MediaQuery.of(context).size.height * 0.02,),

          buildTextFields(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Text('Price', style: TextStyle(fontSize: 18),)),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isBuyNowPrice = true;
                          isAuction = false;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                            color: cyanColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 0.4,
                                blurRadius: 2,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(4)),
                        child: const Text('Buy now',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isAuction = true;
                          isBuyNowPrice = false;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        decoration: BoxDecoration(
                            color: cyanColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 0.4,
                                blurRadius: 2,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            //  border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4)),
                        child: const Text('Auction',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),),
                      ),
                    ),
                  ],
                ),
              ),
              isBuyNowPrice == false ? Container() :
              Column(
                children: [
                  buildTextFieldsBuyNow(),
                ],
              ),
              isAuction == false ? Container() :
              Column(
                children: [
                  buildTextFieldsAuction(),
                ],
              ),
            ],
          ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.12),
                GestureDetector(
                  // onTap: (){
                  //   showPopUp(context);
                  // },
                  onTap: () async {
                    // imagesList();
                    if(formKey.currentState!.validate()) {
                      // if (selectedImages.isEmpty) {
                      //   // toastMessage("Please select image", Colors.red);
                      // }
                      if (isBuyNowPrice == true && isAuction == true) {
                        setState(() {
                          productPriceControllerBuyNow.clear();
                          localDeliveryPriceControllerBuyNow.clear();
                          internationalDeliveryPriceControllerBuyNow.clear();
                          startingPriceControllerAuction.clear();
                          localDeliveryPriceControllerAuction.clear();
                          internationalDeliveryPriceControllerAuction.clear();
                        });
                        toastMessage("Please fill only one form BuyNow OR Auction", Colors.red);
                      }
                      else if (isBuyNowPrice == false && isAuction == false) {
                        toastMessage("Please select BuyNowPrice OR AuctionPrice", Colors.red);
                      }
                      else if (isBuyNowPrice == true && isAuction == false) {
                        if (formKeyBuyNow.currentState!.validate()) {
                          await productUploadWidget().then((value) {
                            setState(() {
                              // toastMessage("Product uploaded Successfully...!", Colors.green);
                              // selectedImages.clear();
                              // productNameController.clear();
                              // productDescriptionController.clear();
                              // productPriceControllerBuyNow.clear();
                              // localDeliveryPriceControllerBuyNow.clear();
                              // internationalDeliveryPriceControllerBuyNow.clear();
                            });
                          });
                        }
                      }
                      else if (isAuction == true && isBuyNowPrice == false) {
                        if (formKeyAuction.currentState!.validate()) {
                          await productUploadWidget().then((value) {
                            setState(() {
                              // toastMessage("Product uploaded Successfully!", Colors.green);
                              // selectedImages.clear();
                              // startingPriceControllerAuction.clear();
                              // localDeliveryPriceControllerAuction.clear();
                              // internationalDeliveryPriceControllerAuction.clear();
                            });
                          });
                        }
                      }
                    }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: primarycolor,
                          borderRadius: BorderRadius.circular(10)),
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      child: myLoader == true
                          ? CircularProgressIndicator()
                          :  Text(
                        'Continue',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,)
                ],
            ),
          ),
        ),
    );
  }

  // createBottomSheet(BuildContext context){
  //   showModalBottomSheet(context: context,
  //       isDismissible: true,
  //       builder: (context)=>StatefulBuilder(
  //           builder: (BuildContext context, StateSetter setState /*You can rename this!*/) {
  //             return Container(
  //               height: MediaQuery.of(context).size.height * 0.1,
  //               color: Colors.transparent,
  //               child: Padding(
  //                 padding: const EdgeInsets.all(20.0),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                   children: [
  //                     GestureDetector(
  //                       onTap: (){
  //                         pickImagesFormGallery();
  //                       },
  //                       child: Container(
  //                         decoration: BoxDecoration(
  //                             borderRadius: BorderRadius.circular(10),
  //                             border: Border.all(color: cyanColor, width: 2)
  //                         ),
  //                         child: const Padding(
  //                           padding: EdgeInsets.all(8.0),
  //                           child: Text("Select from gallery", style: TextStyle(
  //                               fontSize: 16, fontWeight: FontWeight.bold),),
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             );
  //           }));
  // }

  showPopUpForImagePicker(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          print('mmm');
          return Scaffold(
              backgroundColor: Colors.transparent,
              body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        height: MediaQuery.of(context).size.height * 0.07,
                        decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(05)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Icon(Icons.file_copy, color: blackColor,),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                pickImage();
                                // pickImagesFormGallery();
                              },
                              child: Container(
                                child: Text('Gallery',
                                  style: TextStyle(fontSize: 20, color: blackColor),),
                              ),
                            ),
                          ],
                        ))
                  ]
              ));
        });
  }

  Widget buildTextFields() {
    return Container(
      color: Colors.transparent,
      child: Column(
        children: [
          Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                        border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(05)),
                  child: TextFormField(
                    controller: productNameController,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter product name',
                        labelText: 'Enter product name'),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'product name is Required';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(05)),
                  child: TextFormField(
                    controller: productDescriptionController,
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.multiline,
                    maxLines: 6,
                    decoration: const InputDecoration(
                        alignLabelWithHint: true,
                        border: InputBorder.none,
                        hintText: 'Enter description',
                        labelText: 'Enter description'),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'description is Required';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextFieldsAuction() {
    return Container(
      color: Colors.transparent,
      child: Column(
        children: [
          Form(
            key: formKeyAuction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      //   border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20)),
                  child: TextFormField(
                    controller: startingPriceControllerAuction,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter starting price',
                        labelText: 'Enter starting price'),
                    keyboardType: TextInputType.number,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'starting price is Required';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      //   border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20)),
                  child: TextFormField(
                    controller: localDeliveryPriceControllerAuction,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter local delivery price',
                        labelText: 'Enter local delivery price'),
                    keyboardType: TextInputType.number,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'local delivery price is Required';
                      }
                      return null;
                    },

                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      //   border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20)),
                  child: TextFormField(
                    controller: internationalDeliveryPriceControllerAuction,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter international delivery price',
                        labelText: 'Enter international delivery price'),
                    keyboardType: TextInputType.number,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'international delivery price is Required';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      //border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      hint: dropDownValue == null ? const Text('')
                          : Text(dropDownValue!, style: const TextStyle(color: Colors.black),),
                      isExpanded: true,
                      iconSize: 30.0,
                      style: const TextStyle(color: Colors.black),
                      items: [
                        '1 day',
                        '2 days',
                        '3 days',
                        '4 days',
                        '5 days',
                        '6 days',
                        '7 days',
                        '8 days',
                        '9 days',
                        '10 days',
                        '11 days',
                        '12 days',
                        'Until further notice'
                      ].map((val) {
                          return DropdownMenuItem<String>(
                            value: val,
                            child: Text(val),
                          );
                        },
                      ).toList(),
                      onChanged: (val) {
                        setState(() {
                          dropDownValue = val as String?;
                          print("dropDownValue: $dropDownValue");
                        },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextFieldsBuyNow() {
    return Container(
      color: Colors.transparent,
      child: Column(
        children: [
          Form(
            key: formKeyBuyNow,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      //   border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20)),
                  child: TextFormField(
                    controller: productPriceControllerBuyNow,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter product price',
                        labelText: 'Enter product price'),
                    keyboardType: TextInputType.number,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'product price is Required';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      //   border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20)),
                  child: TextFormField(
                    controller: localDeliveryPriceControllerBuyNow,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter local delivery price',
                        labelText: 'Enter local delivery price'),
                    keyboardType: TextInputType.number,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'local delivery price is Required';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      //   border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20)),
                  child: TextFormField(
                    controller: internationalDeliveryPriceControllerBuyNow,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter international delivery price',
                        labelText: 'Enter international delivery price'),
                    keyboardType: TextInputType.number,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'international delivery price is Required';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  showPopUp(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          print('mmm');
          return Scaffold(
              backgroundColor: Colors.transparent,
              body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        height: MediaQuery.of(context).size.height * 0.16,
                        decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(6)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Do you want publish your product?"),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                    // pickCoverImage(ImageSource.gallery);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 8, top: 16),
                                    child: Text('No',
                                      style: TextStyle(fontSize: 20, color: blackColor),),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    // Navigator.pop(context);
                                      imagesList();
                                      if(selectedImages.isEmpty){
                                        toastMessage("Please select image", Colors.red);
                                        if(formKey.currentState!.validate()){}
                                      }
                                      else if(isBuyNowPrice == true && isAuction == true ){
                                        setState(() {
                                          productPriceControllerBuyNow.clear();
                                          localDeliveryPriceControllerBuyNow.clear();
                                          internationalDeliveryPriceControllerBuyNow.clear();
                                          startingPriceControllerAuction.clear();
                                          localDeliveryPriceControllerAuction.clear();
                                          internationalDeliveryPriceControllerAuction.clear();
                                        });
                                        toastMessage("Please fill only one form BuyNow OR Auction", Colors.red);
                                      }
                                      else if(isBuyNowPrice == false && isAuction == false ){
                                        toastMessage("Please select BuyNowPrice OR AuctionPrice", Colors.red);
                                      }
                                      else if(isBuyNowPrice == true && isAuction == false){
                                        if(formKeyBuyNow.currentState!.validate()){
                                          await productUploadWidget().then((value){
                                            setState(() {
                                              toastMessage("Product uploaded Successfully...!", Colors.green);
                                              selectedImages.clear();
                                              productPriceControllerBuyNow.clear();
                                              localDeliveryPriceControllerBuyNow.clear();
                                              internationalDeliveryPriceControllerBuyNow.clear();
                                              Navigator.pop(context);
                                            });
                                          });
                                        }
                                      }
                                      else if(isAuction == true && isBuyNowPrice == false){
                                        if(formKeyAuction.currentState!.validate()){
                                          await productUploadWidget().then((value){
                                            setState(() {
                                              toastMessage("Product uploaded Successfully!", Colors.green);
                                              selectedImages.clear();
                                              startingPriceControllerAuction.clear();
                                              localDeliveryPriceControllerAuction.clear();
                                              internationalDeliveryPriceControllerAuction.clear();
                                              Navigator.pop(context);
                                            });
                                          });
                                        }
                                      }
                                      // },
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 8, top: 16),
                                    child: Text('Yes',
                                      style: TextStyle(fontSize: 20, color: blackColor),),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ))
                  ]
              ));
        });
  }
}