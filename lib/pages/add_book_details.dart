import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get_it/get_it.dart';
import 'package:trackfolio/services/book_details_service.dart';
import 'package:trackfolio/services/firebase_firestore_service.dart';

class AddBookDetails extends StatefulWidget {
  AddBookDetails({super.key, required this.isbn});
  final String isbn;

  @override
  State<AddBookDetails> createState() => _AddBookDetailsState();
}

class _AddBookDetailsState extends State<AddBookDetails> {
  Future<Map>? _bookData;
  double? _deviceWidth;
  @override
  void initState() {
    super.initState();
    _bookData = getBookDataByIsbn(widget.isbn);
  }

  FirebaseFirestoreService _firestore = GetIt.instance
      .get<FirebaseFirestoreService>();

  final List<DropdownMenuItem<String>> _items =
      ['To-Read', 'Reading', 'Read', 'Dropped'].map((String value) {
        return DropdownMenuItem<String>(child: Text(value), value: value);
      }).toList();
  String _selectedStatus = 'To-Read';
  double? _rating;

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
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
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                    _bookAuthor(author),
                    _bookPublishedDate(publishedDate),
                    _bookPageCount(pageCount),
                    _statusDropDown(),
                    _ratingBar(),
                    _addBookButton(
                      title,
                      author,
                      publishedDate,
                      int.parse(pageCount),
                      imageLink,
                    ),
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
    return Column(
      children: [
        Text(
          'Status',
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        DropdownButton<String>(
          menuWidth: 150,
          borderRadius: BorderRadius.circular(20),
          underline: Container(),
          items: _items,
          value: _selectedStatus,
          dropdownColor: Color.fromRGBO(255, 255, 255, 1),
          style: TextStyle(color: Colors.black, fontSize: 15),
          onChanged: (value) {
            setState(() {
              _selectedStatus = value!;
            });
          },
        ),
      ],
    );
  }

  Widget _ratingBar() {
    return Column(
      children: [
        Text(
          'Rating',
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        RatingBar.builder(
          initialRating: 0,
          minRating: 0,
          direction: Axis.horizontal,
          allowHalfRating: false,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
          onRatingUpdate: (rating) {
            setState(() {
              _rating = rating;
            });
          },
        ),
      ],
    );
  }

  Widget _addBookButton(
    String title,
    String author,
    String publishedDate,
    int pageCount,
    String imageURL,
  ) {
    return SizedBox(
      width: _deviceWidth! * 0.80,
      child: OutlinedButton(
        onPressed: () {
          _firestore.addingBookData(
            author: author,
            imageURL: imageURL,
            ownerId: '',
            pageCount: pageCount,
            publishedDate: publishedDate,
            rating: _rating!,
            status: _selectedStatus,
            title: title,
          );
        },
        child: Text('Add Book'),
      ),
    );
  }
}
