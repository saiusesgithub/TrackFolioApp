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
  title = title.trim();
  final response = await dio.get(
    'https://www.googleapis.com/books/v1/volumes',
    queryParameters: {'q': 'intitle:"$title"', 'maxResults': 5},
    options: Options(responseType: ResponseType.json),
  );

  final data = response.data['items'];
  if (data == null || data.isEmpty) {
    throw Exception('No book found');
  }

  final normalized = title.toLowerCase();
  final best = data.firstWhere(
    (data) =>
        (data['volumeInfo']?['title'] ?? '').toString().toLowerCase() ==
        normalized,
    orElse: () => data[0],
  );

  final item = best['volumeInfo'];

  Map _bookData = {
    'title': item['items'][0]['volumeInfo']['title'],
    'publishedDate': item['items'][0]['volumeInfo']['publishedDate'],
    'pageCount': item['items'][0]['volumeInfo']['pageCount'],
    'image': item['items'][0]['volumeInfo']['imageLinks']['thumbnail'],
    'author': item['items'][0]['volumeInfo']['authors'][0],
    'description': item['items'][0]['volumeInfo']['description'],
    'avgRating': item['items'][0]['volumeInfo']['averageRating'],
    'categories': item['items'][0]['volumeInfo']['categories'],
  };
  return _bookData;
}
