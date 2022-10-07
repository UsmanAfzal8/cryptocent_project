class CoinsWallet {
  CoinsWallet({
    required this.symble,
    required this.address,
    required this.transferKey,
    required this.wallet,
  });
  final String symble;
  final String address;
  final String transferKey;
  final String wallet;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'symble': symble.trim().toLowerCase(),
      'address': address,
      'transfer_key': transferKey,
      'wallet': wallet,
    };
  }

  // ignore: sort_constructors_first
  factory CoinsWallet.fromMap(Map<String, dynamic> map) {
    return CoinsWallet(
      symble: map['symble'] as String,
      address: map['address'] as String,
      transferKey: map['transfer_key'] as String,
      wallet: map['wallet'] as String,
    );
  }
}
