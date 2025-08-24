import 'package:flutter/material.dart';

class SearchBookPage extends StatefulWidget {
  const SearchBookPage({super.key});

  @override
  State<SearchBookPage> createState() => _SearchBookPageState();
}

class _SearchBookPageState extends State<SearchBookPage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _isbnController = TextEditingController();
  String? bookTitle;
  String? bookIsbn;
  double? _deviceWidth;

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(161, 255, 206, 1.0).withValues(alpha: 0.5),
                Color.fromRGBO(250, 255, 209, 1.0).withValues(alpha: 0.5),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    _bookTitleTextField(),
                    Center(child: Text("OR")),
                    _isbnTextField(),
                  ],
                ),
                _searchButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _bookTitleTextField() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        controller: _titleController,
        onSubmitted: (value) {
          bookTitle = value;
        },
        decoration: InputDecoration(
          hintText: "Title Of The Book...",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }

  Widget _isbnTextField() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        controller: _isbnController,
        onSubmitted: (value) {
          bookIsbn = value;
        },
        decoration: InputDecoration(
          hintText: "ISBN Of The Book...",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }

  Widget _searchButton() {
    return SizedBox(
      width: _deviceWidth! * 0.90,
      child: OutlinedButton(
        onPressed: () {},
        child: Text("Search For The Book"),
      ),
    );
  }
}
