import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../buydata/customtoast.dart';

class SignInApi {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _instance = FirebaseFirestore.instance;
  static const String _collection = 'user';
  static String get uid => _auth.currentUser?.uid ?? '';
  Future<bool> signin({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: email.toLowerCase().trim(), password: password);
      CustomToast.successToast(message: 'Successfully');
      return true;
    } catch (err) {
      CustomToast.errorToast(message: err.toString());
      return false;
    }
  }

  // Future<AppUser> get() async {
  //   AppUser? user;
  //   DocumentSnapshot<Map<String, dynamic>> snapshot =
  //       await _instance.collection(_collection).doc(AuthApi.uid).get();
  //   user = (AppUser.fromMap(snapshot));
  //   return user;
  // }
}
