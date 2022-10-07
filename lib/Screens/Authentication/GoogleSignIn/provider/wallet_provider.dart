import 'package:flutter/cupertino.dart';

import '../../../../Models/MessagesModels/wallets.dart';
import '../../../../Models/wallet.dart';
import '../../../../Models/wallet_api.dart';

class WalletProvider with ChangeNotifier {
  List<Wallets> _wallets = <Wallets>[];
  List<Wallets> get wallets => _wallets;
  String _walletaddress = '37YBQoYNQ4NZUbaoeifhk96eiCbCktrySK';
  String get walletsAddress => _walletaddress;
  String transferKey = 'x31TPExSJSpWCGjCBhuDLAIdMjYAc4Tc';
  String walletID = 'btc-1b8192fb3347e29d5e1b2d1845939ab4';
  double _balance = 0;
  double get balance => _balance;
  updateBalance() async {
    _balance = await WallletWithApi().getWalletBalance(walletsAddress);
    notifyListeners();
  }

  walletAddress(String address, String key, String wallet) {
    _walletaddress = address;
    transferKey = key;
    walletID = wallet;
    updateBalance();
    notifyListeners();
  }

  load(Wallets wallet) {
    _wallets.clear();
    _wallets.add(wallet);
    notifyListeners();
  }

  Future<bool> dataLoad(String seedid) async {
    _wallets.clear();
    bool temp = false;
    _wallets = await WalletsApi().get(seedid);
    temp = true;
    return temp;
  }
}
