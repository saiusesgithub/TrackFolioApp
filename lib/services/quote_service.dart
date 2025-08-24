import 'package:dio/dio.dart';

final dio = Dio();

Future<List<String>> getQuote() async {
  final response = await dio.get(
    'https://zenquotes.io/api/quotes/keyword=inspiration',
  );
  List<String> _data = [response.data[0]['q'], response.data[0]['a']];
  return _data;
}
