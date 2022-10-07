import 'package:cloud_firestore/cloud_firestore.dart';

import 'MessagesModels/coinswallet.dart';

class Wallets {
  Wallets({
    required this.walletId,
    required this.uid,
    required this.seedid,
    required this.coinsWallet,
  });
  final String uid;
  final String seedid;
  final String walletId;
  final List<CoinsWallet> coinsWallet;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'seed_id': seedid,
      'wallet_id': walletId,
      'coins_wallet': coinsWallet.map((CoinsWallet x) => x.toMap()).toList(),
    };
  }

  // ignore: sort_constructors_first
  factory Wallets.fromMap(DocumentSnapshot<Map<String, dynamic>> doc) {
    final List<dynamic> data = doc.data()?['coins_wallet'];
    final List<CoinsWallet> coinsInfo = <CoinsWallet>[];
    for (dynamic element in data) {
      final CoinsWallet temp = CoinsWallet.fromMap(element);
      coinsInfo.add(temp);
    }
    return Wallets(
      uid: doc.data()?['uid'] ?? '',
      seedid: doc.data()?['seed_id'] ?? '',
      walletId: doc.data()?['wallet_id'] ?? '',
      coinsWallet: coinsInfo,
    );
  }
}
