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

  Future<bool> addingBookDataByIsbn({
    required String author,
    required String imageURL,
    required String ownerId,
    required int pageCount,
    required String publishedDate,
    required double rating,
    required String status,
    required String title,
  }) async {
    try {
      await _firestore.collection('books').doc().set({
        "author": author,
        "imageURL": imageURL,
        "ownerId": ownerId,
        "publishedDate": publishedDate,
        "pageCount": pageCount,
        "rating": rating,
        "status": status,
        "title": title,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> addingBookDataByName({
    required String author,
    required String imageURL,
    required String ownerId,
    required int pageCount,
    required String publishedDate,
    required double rating,
    required String status,
    required String title,
    required String description,
    required double avgRating,
    required List categories,
  }) async {
    try {
      await _firestore.collection('books').doc().set({
        "author": author,
        "imageURL": imageURL,
        "ownerId": ownerId,
        "publishedDate": publishedDate,
        "pageCount": pageCount,
        "rating": rating,
        "status": status,
        "title": title,
        "description": description,
        "avgRating": avgRating,
        "categories": categories,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
