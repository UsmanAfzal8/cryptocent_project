import 'package:crypto_cent/Screens/buydata/customtoast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Models/MessagesModels/wallets.dart';
import '../../Authentication/GoogleSignIn/provider/wallet_provider.dart';

class SendBitcoinScreen extends StatefulWidget {
  const SendBitcoinScreen({Key? key}) : super(key: key);

  @override
  State<SendBitcoinScreen> createState() => _SendBitcoinScreenState();
}

class _SendBitcoinScreenState extends State<SendBitcoinScreen> {
  TextEditingController _walletaddress = TextEditingController();
  TextEditingController _amount = TextEditingController();
  btcSend() async {
    WalletProvider walletPro =
        Provider.of<WalletProvider>(context, listen: false);
    String walletId = '';
    String transferKey = '';
    String temp = _amount.text;
    double amount = double.parse(temp);
    if (walletPro.balance > amount) {
      await WallletWithApi().transferCoin(
          walletId, transferKey, _walletaddress.text, amount.toString());
    } else {
      CustomToast.errorToast(message: 'You havenot enough Balance ');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Text(
                'Enter BTC Address :',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 60,
                width: double.infinity,
                child: TextFormField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(8.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    hintText: "0",
                  ),
                  controller: _walletaddress,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Amount :',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 60,
                width: 130,
                child: TextFormField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(8.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    hintText: "0",
                  ),
                  controller: _amount,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        btcSend();
                      },
                      child: Text('Send')))
            ],
          ),
        ),
      ),
    );
  }
}
