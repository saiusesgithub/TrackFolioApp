import 'package:dio/dio.dart';
import 'dart:convert';

final dio = Dio();

void main() {
  String x = "1847941834";
  getBookDataByIsbn(x);
}

Future<Map> getBookDataByIsbn(String _isbn) async {
  final response = await dio.get(
    'https://www.googleapis.com/books/v1/volumes?q=isbn:$_isbn',
  );
  Map _bookData = {
    'title': response.data['items'][0]['volumeInfo']['title'],
    'publishedDate': response.data['items'][0]['volumeInfo']['publishedDate'],
    'pageCount': response.data['items'][0]['volumeInfo']['pageCount'],
    'image': response.data['items'][0]['volumeInfo']['imageLinks']['thumbnail'],
    'author': response.data['items'][0]['volumeInfo']['authors'][0],
  };
  return _bookData;
}