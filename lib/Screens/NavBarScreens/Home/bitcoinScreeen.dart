import 'package:crypto_cent/Models/wallet_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../Models/MessagesModels/wallets.dart';
import '../../Authentication/GoogleSignIn/provider/wallet_provider.dart';
import '../../Authentication/SignUp/signup_screen.dart';

class ReceiveBTCScreen extends StatefulWidget {
  const ReceiveBTCScreen({Key? key}) : super(key: key);

  @override
  State<ReceiveBTCScreen> createState() => _ReceiveBTCScreenState();
}

class _ReceiveBTCScreenState extends State<ReceiveBTCScreen> {
  void initState() {
    super.initState();
    getBalance();
  }

  double balance = 0;
  Future<void> getBalance() async {
    WalletProvider walletPro =
        Provider.of<WalletProvider>(context, listen: false);
    balance = await WallletWithApi().getWalletBalance(walletPro.walletsAddress);
  }

  @override
  Widget build(BuildContext context) {
    WalletProvider walletPro = Provider.of<WalletProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 16),
              QrImage(
                data: walletPro.walletsAddress,
                version: QrVersions.auto,
                size: 120.0,
              ),
              const SizedBox(height: 16),
              const Text(
                'Your BTC Address :',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              const SizedBox(height: 16),
              // InkWell(
              //   onTap: () async {
              //     await Clipboard.setData(const ClipboardData(
              //       text: 'https://devmarkaz.com',
              //     )).then((_) =>
              //         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              //           content: Text('Copied to your clipboard !'),
              //         )));
              //   },
              //   borderRadius: BorderRadius.circular(12),
              //   child: Container(
              //     padding: const EdgeInsets.all(16),
              //     margin: const EdgeInsets.symmetric(vertical: 16),
              //     decoration: BoxDecoration(
              //       color: Colors.grey,
              //       borderRadius: BorderRadius.circular(12),
              //     ),
              //     alignment: Alignment.center,
              //     child: Row(
              //       children: <Widget>[
              //         const Flexible(
              //           child: Text(
              //             'https://devmarkaz.com',
              //             textAlign: TextAlign.center,
              //           ),
              //         ),
              //         IconButton(
              //           onPressed: () async {
              //             await Clipboard.setData(const ClipboardData(
              //               text: 'https://devmarkaz.com',
              //             )).then((_) => ScaffoldMessenger.of(context)
              //                     .showSnackBar(const SnackBar(
              //                   content: Text('Copied to your clipboard !'),
              //                 )));
              //           },
              //           splashRadius: 16,
              //           icon: const Icon(Icons.copy),
              //         )
              //       ],
              //     ),
              //   ),
              // ),

              Text(
                walletPro.walletsAddress,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    'Your Balance : ',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  Text(
                    balance.toString(),
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                ],
              ),
              // const SizedBox(height: 16),
              // TextButton(
              //   onPressed: () {},
              //   child: const Text(
              //     'Share',
              //     style: TextStyle(fontSize: 32),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
