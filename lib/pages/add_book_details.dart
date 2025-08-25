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

  final List<DropdownMenuItem<String>> _items =
      ['To-Read', 'Reading', 'Read', 'Dropped'].map((String value) {
        return DropdownMenuItem<String>(child: Text(value), value: value);
      }).toList();
  String _selectedStatus = 'To-Read';

  @override
  Widget build(BuildContext context) {
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
                  (_data?['publishedDate'].toString() ??
                  'Unknown Published Date');
              String pageCount = (_data?['pageCount'] ?? 'Unknown Page Count')
                  .toString();

              String imageLink =
                  _data?['image'] ??
                  'https://greenhousescribes.com/wp-content/uploads/2020/10/book-cover-generic-642x1024.jpg';
              if (imageLink.startsWith('http://')) {
                imageLink = imageLink.replaceFirst('http://', 'https://');
              }
              String author = _data?['author'] ?? 'Unknown Author';

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(imageLink),
                          ),
                        ),
                      ),
                    ),
                    _bookTitle(title),
                    SizedBox(height: 50),
                    _bookAuthor(author),
                    _bookPublishedDate(publishedDate),
                    _bookPageCount(pageCount),
                    _statusDropDown(),
                  ],
                ),
              );
            } else {
              return const Center(child: Text("No data found or error"));
            }
          },
        ),
      ),
    );
  }

  Widget _bookTitle(String title) {
    return Center(
      child: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 25,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _bookAuthor(String author) {
    return Text(
      'by $author',
      style: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _bookPublishedDate(String date) {
    return Text(
      'Date Published - $date',
      style: TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _bookPageCount(String pages) {
    return Text(
      'Page Count - $pages',
      style: TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _statusDropDown() {
    return Container(
      child: DropdownButton<String>(
        underline: Container(),
        items: _items,
        value: _selectedStatus,
        dropdownColor: Color.fromRGBO(53, 53, 53, 1.0),
        style: TextStyle(color: Colors.white),
        onChanged: (value) {
          setState(() {
            _selectedStatus = value!;
          });
        },
      ),
    );
  }
}
