import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'coinswallet.dart';

class WallletWithApi {
  static String myWalletId = '';
  static String url = 'https://apirone.com/api/v2/wallets';
  List<String> units = [
    'btc',
  ];

  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
  };
  Future<List<CoinsWallet>> createWallet() async {
    final List<CoinsWallet> coinsWallet = <CoinsWallet>[];
    String? endpointUrl = dotenv.env['ENDPOINT_URL'];
    for (String un in units) {
      Map<String, dynamic> body = <String, dynamic>{
        'type': 'saving',
        'currency': un,
        'callback': {
          'url': '${endpointUrl!}notifications-wallet.php',
        }
      };
      try {
        await http
            .post(Uri.parse(url),
                headers: requestHeaders, body: jsonEncode(body))
            .then((http.Response value) async {
          if (value.statusCode == 200) {
            var body = jsonDecode(value.body);

            String walletId = body['wallet'];
            String transferKey = body['transfer_key'];

            try {
              http.Response? addressResponse = await http
                  .post(
                Uri.parse('$url/$walletId/addresses'),
                headers: requestHeaders,
              )
                  .then((http.Response value) {
                if (value.statusCode == 200) {
                  var body = jsonDecode(value.body);
                  String address = body['address'];
                  // String encryptedAddress = (address);

                  // Map<String, dynamic> WalletData = {
                  //   '${un}_transfer_key': transferKey,
                  //   '${un}_wallet': walletId,
                  //   '${un}_address': address,
                  // };
                  // wallets.addAll(WalletData);
                  CoinsWallet coinInfo = CoinsWallet(
                    symble: un,
                    address: address,
                    transferKey: transferKey,
                    wallet: walletId,
                  );
                  coinsWallet.add(coinInfo);
                } else {
                  print('error');
                }
              }).timeout(
                const Duration(seconds: 60),
              );
              return addressResponse;
            } catch (e) {
              //print(e);
            }
          }
        }).timeout(
          const Duration(seconds: 60),
        );
      } catch (e) {
        // print(e);
      }
    }

    return coinsWallet;
  }
   String TRANSFERKEY = 'transfer_key';
   String DESTINATIONS = 'destinations';
   String ADDRESS = 'address';
   String AMOUNT = 'amount';
   String STATUS = 'status';
   String HASH = 'hash';
  Future<Map> transferCoin(
    String walletId,
    String transferKey,
    String address,
    String amount,
  ) async {
    Map result;

    Map<String, dynamic> trxnBody = {
      TRANSFERKEY: transferKey,
      DESTINATIONS: [
        {
          ADDRESS: address,
          AMOUNT: (double.tryParse(amount)! * 100000000).toInt()
        },
      ],
    };
    try {
      http.Response response = await http
          .post(Uri.parse('$url/$walletId/transfer'),
              headers: requestHeaders, body: jsonEncode(trxnBody))
          .timeout(
            const Duration(seconds: 30),
          );

      var body = jsonDecode(response.body);
      int status = response.statusCode;
      var txs = body['txs'];

      if (status == 200) {
        result = {
          STATUS: true,
          HASH: txs,
        };

        return result;
      } else {
        result = {
          STATUS: false,
          HASH: null,
        };

        return result;
      }
    } catch (e) {
      print(e);
      result = {
        STATUS: false,
        HASH: null,
      };

      return result;
    }
  }
Future<double> getWalletBalance(String walletIds) async {
    double temp = 0;  
     try {
        await http
            .get(
                Uri.parse(
                  '$url/$walletIds/balance',
                ),
                headers: requestHeaders)
            .then((http.Response value) {
          if (value.statusCode == 200) {
            var body = jsonDecode(value.body);
     // print('body $body');
            double available = ((body['available']) / 100000000.00);
            double total = ((body['total']) / 100000000.00);
             temp=total;
           
          }
        }).timeout(
          const Duration(seconds: 30),
        );
      } catch (e) {
        print(e);
      }
    return temp;
    }
    
  static const String HEXCHARS = 'abcdef0123456789';
  String hexString(int strlen) {
    Random rnd = Random(DateTime.now().millisecondsSinceEpoch);
    String result = '';
    for (int i = 0; i < strlen; i++) {
      result += HEXCHARS[rnd.nextInt(HEXCHARS.length)];
    }
    return result;
  }
}
