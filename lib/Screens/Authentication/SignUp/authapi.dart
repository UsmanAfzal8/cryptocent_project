import 'package:firebase_auth/firebase_auth.dart';

import '../../buydata/customtoast.dart';
class AuthApi {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static String? get uid => _auth.currentUser?.uid;

  Future<User?> signupUser({
    required String email,
    required String password,
  }) async {
    try {
      print('Enter the Auth method');
      UserCredential cer = await _auth.createUserWithEmailAndPassword(
          email: email.toLowerCase().trim(), password: password);
      print(cer.user!.uid);
      CustomToast.successToast(message: 'Successfully Added');
      return cer.user;
      // await _firestore.collection(_collection).doc(cer.user!.uid).set(
      //       employer.toJson(),
      //     );
      // return true;
    } catch (err) {
      CustomToast.errorToast(message: err.toString());
      return null;
    }
  }
}
