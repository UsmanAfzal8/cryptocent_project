import 'package:crypto_cent/Utils/color.dart';
import 'package:crypto_cent/widgets/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class TopupScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TopupScreenState();
  }
}

class TopupScreenState extends State<TopupScreen> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  OutlineInputBorder? border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.7),
        width: 2.0,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        iconTheme: IconThemeData(color: kBlack),
        title: Text(
          'Topup',
          style: TextStyle(color: kBlack, fontSize: 20),
        ),
        backgroundColor: kWhite,
      ),
      // resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          color: kWhite,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 6,
              ),
              CreditCardWidget(
                glassmorphismConfig:
                    useGlassMorphism ? Glassmorphism.defaultConfig() : null,
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                showBackView: isCvvFocused,
                obscureCardNumber: true,
                obscureCardCvv: true,
                isHolderNameVisible: true,
                cardBgColor: cyanColor,
                backgroundImage:
                    useBackgroundImage ? 'assets/images/card_bg.png' : null,
                isSwipeGestureEnabled: true,
                onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
                customCardTypeIcons: <CustomCardTypeIcon>[
                  CustomCardTypeIcon(
                    cardType: CardType.mastercard,
                    cardImage: Image.asset(
                      'assets/images/mastercard.png',
                      height: 48,
                      width: 48,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.bottomLeft,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Text(
                  'Enter Amount',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                decoration: BoxDecoration(
                  color: grey100,
                  borderRadius: BorderRadius.circular(30),
                  //border: Border.all(color: Colors.grey.shade300)
                ),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: const TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '200 ',
                      hintStyle: TextStyle()),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                decoration: BoxDecoration(
                  color: grey100,
                  borderRadius: BorderRadius.circular(30),
                  //border: Border.all(color: Colors.grey.shade300)
                ),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: const TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Number',
                      hintText: 'XXXX XXXX XXXX XXXX',
                      hintStyle: TextStyle()),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2.34,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 2),
                      margin: const EdgeInsets.only(left: 20, right: 5),
                      decoration: BoxDecoration(
                          color: grey100,
                          //  border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(30)),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Expired Date',
                          hintText: 'XX/XX',
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2.34,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 2),
                      margin: const EdgeInsets.only(left: 5, right: 20),
                      decoration: BoxDecoration(
                          color: grey100,
                          //  border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(30)),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText: 'CVV',
                          hintText: 'XXX',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                decoration: BoxDecoration(
                  color: grey100,
                  borderRadius: BorderRadius.circular(30),
                  //border: Border.all(color: Colors.grey.shade300)
                ),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: const TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Card Holder',
                      hintStyle: TextStyle()),
                ),
              ),
              Column(
                children: <Widget>[
                  // CreditCardForm(
                  //   formKey: formKey,
                  //   obscureCvv: true,
                  //   obscureNumber: true,
                  //   cardNumber: cardNumber,
                  //   cvvCode: cvvCode,
                  //   isHolderNameVisible: true,
                  //   isCardNumberVisible: true,
                  //   isExpiryDateVisible: true,
                  //   cardHolderName: cardHolderName,
                  //   expiryDate: expiryDate,
                  //   themeColor: Colors.blue,
                  //   textColor: kBlack,
                  //   cardNumberDecoration: InputDecoration(
                  //     labelText: 'Number',
                  //     hintText: 'XXXX XXXX XXXX XXXX',
                  //     hintStyle: TextStyle(color: kBlack),
                  //     labelStyle: TextStyle(color: kBlack),
                  //     focusedBorder: border,
                  //     // enabledBorder: border,
                  //   ),
                  //   expiryDateDecoration: InputDecoration(
                  //     focusedBorder: border,
                  //     // enabledBorder: border,
                  //     labelText: 'Expired Date',
                  //     hintText: 'XX/XX',
                  //   ),
                  //   cvvCodeDecoration: InputDecoration(
                  //     focusedBorder: border,
                  //     // enabledBorder: border,
                  //     labelText: 'CVV',
                  //     hintText: 'XXX',
                  //   ),
                  //   cardHolderDecoration: InputDecoration(
                  //     focusedBorder: border,
                  //     // enabledBorder: border,
                  //     labelText: 'Card Holder',
                  //   ),
                  //   onCreditCardModelChange: onCreditCardModelChange,
                  // ),

                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      primary: cyanColor,
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(12),
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          color: kBlack,
                          // fontFamily: 'halter',
                          fontSize: 14,
                          package: 'flutter_credit_card',
                        ),
                      ),
                    ),
                    onPressed: () {
                      toastMessage('Amount added to wallet successfully', Colors.green);
                      if (formKey.currentState!.validate()) {
                        print('valid!');
                      } else {
                        print('invalid!');
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
