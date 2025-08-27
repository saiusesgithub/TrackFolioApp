import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trackfolio/services/firebase_firestore_service.dart';
import 'package:trackfolio/models/book_model.dart';

class ToReadBooksList extends StatefulWidget {
  const ToReadBooksList({super.key});

  @override
  State<ToReadBooksList> createState() => _ToReadBooksListState();
}

class _ToReadBooksListState extends State<ToReadBooksList> {
  FirebaseFirestoreService _firebase = FirebaseFirestoreService();

  Widget build(BuildContext context) {
    String _userId = FirebaseAuth.instance.currentUser!.uid;
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<List<Book>>(
          stream: _firebase.getBooksByStatus(_userId, 'To-Read'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Text("Error Occured While Fetching Books");
            }
            final books = snapshot.data ?? const [];
            if (!snapshot.hasData) {
              return Text('No Books Added');
            }
            return booksGridView(booksList: books);
          },
        ),
      ),
    );
  }
}

Widget booksGridView({required List<Book> booksList}) {
  return GridView.builder(
    padding: EdgeInsets.all(8.0),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 8.0,
      mainAxisSpacing: 8.0,
    ),
    itemCount: booksList.length,
    itemBuilder: (context, index) {
      final book = booksList[index];
      return Card(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 150,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(book.imageURL),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(book.title, textAlign: TextAlign.center),
            ],
          ),
        ),
      );
    },
  );
}
