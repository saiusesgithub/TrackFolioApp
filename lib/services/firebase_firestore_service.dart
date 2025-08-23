import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseFirestoreService();

  Future<bool> addingUserName(
    UserCredential _userCredential,
    String _name,
    String _email,
  ) async {
    try {
      String _userId = _userCredential.user!.uid;
      await _firestore.collection('users').doc(_userId).set({
        "name": _name,
        "email": _email,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}

//logging user

//     if (_userCredential.user != null) {
//       currentUser = await getUserData(uid: _userCredential.user!.uid);
//       return true;

// Future<Map> getUserData({required String uid}) async {
//   DocumentSnapshot _doc = await _db.collection(USER_COLLECTION).doc(uid).get();
//   return _doc.data() as Map;
// }

// String _userId = _auth.currentUser!.uid;
