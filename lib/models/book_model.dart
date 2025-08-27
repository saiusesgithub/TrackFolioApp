import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  final String id;
  final String title;
  final String author;
  final String imageURL;
  final String status;
  final String userId;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.imageURL,
    required this.status,
    required this.userId,
  });

  factory Book.RawToStructured(
    QueryDocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final d = doc.data();
    return Book(
      id: doc.id,
      title: (d['title'] ?? '') as String,
      author: (d['author'] ?? '') as String,
      imageURL: (d['imageURL'] ?? '') as String,
      status: (d['status'] ?? '') as String,
      userId: (d['ownerId'] ?? d['userId'] ?? '') as String,
    );
  }
}
