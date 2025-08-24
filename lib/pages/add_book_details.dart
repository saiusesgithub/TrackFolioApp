import 'package:flutter/material.dart';
import 'package:trackfolio/services/book_details_service.dart';

class AddBookDetails extends StatefulWidget {
  AddBookDetails({super.key, required this.isbn});
  final String isbn;

  @override
  State<AddBookDetails> createState() => _AddBookDetailsState();
}

class _AddBookDetailsState extends State<AddBookDetails> {
  Future<Map>? _bookData;
  @override
  void initState() {
    super.initState();
    _bookData = getBookDataByIsbn(widget.isbn);
  }

  @override
  Widget build(BuildContext context) {
    String _isbn = widget.isbn;
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: _bookData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final _data = snapshot.data;
              String title = _data?['title'] ?? 'Unknown Title';
              String publishedDate =
                  (_data?['publishedDate'] ?? 'Unknown Published Date')
                      .toString();
              String pageCount = (_data?['pageCount'] ?? 'Unknown Page Count')
                  .toString();

              String imageLink =
                  _data?['image'] ??
                  'https://greenhousescribes.com/wp-content/uploads/2020/10/book-cover-generic-642x1024.jpg';
              if (imageLink.startsWith('http://')) {
                imageLink = imageLink.replaceFirst('http://', 'https://');
              }
              String author = _data?['author'] ?? 'Unknown Author';

              return Column(
                children: [
                  SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage(imageLink)),
                      ),
                    ),
                  ),
                  Text(title),
                  Text(author),
                  Text(publishedDate),
                  Text(pageCount),
                ],
              );
            } else {
              return const Center(child: Text("No data found or error"));
            }
          },
        ),
      ),
    );
  }
}
