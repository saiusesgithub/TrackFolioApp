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
