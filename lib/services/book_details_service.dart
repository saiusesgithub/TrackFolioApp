import 'package:dio/dio.dart';

final dio = Dio();

Future<Map> getBookDataByIsbn(String isbn) async {
  final response = await dio.get(
    'https://www.googleapis.com/books/v1/volumes',
    queryParameters: {'q': 'isbn:$isbn'},
    options: Options(responseType: ResponseType.json),
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

Future<Map> getBookDataByTitle(String title) async {
  final response = await dio.get(
    'https://www.googleapis.com/books/v1/volumes',
    queryParameters: {'q': 'intitle:$title'},
    options: Options(responseType: ResponseType.json),
  );
  Map _bookData = {
    'title': response.data['items'][0]['volumeInfo']['title'],
    'publishedDate': response.data['items'][0]['volumeInfo']['publishedDate'],
    'pageCount': response.data['items'][0]['volumeInfo']['pageCount'],
    'image': response.data['items'][0]['volumeInfo']['imageLinks']['thumbnail'],
    'author': response.data['items'][0]['volumeInfo']['authors'][0],
    'description': response.data['items'][0]['volumeInfo']['description'],
    'avgRating': response.data['items'][0]['volumeInfo']['averageRating'],
    'categories': response.data['items'][0]['volumeInfo']['categories'],
  };
  return _bookData;
}
