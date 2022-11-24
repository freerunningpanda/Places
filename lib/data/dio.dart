import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

const url = 'https://test-backend-flutter.surfstudio.ru/client/client.html';

const testUrl = 'https://jsonplaceholder.typicode.com';

final dio = Dio(baseoptions);

BaseOptions baseoptions = BaseOptions(
  baseUrl: testUrl,
  connectTimeout: 5000,
  receiveTimeout: 5000,
  sendTimeout: 5000,
  // ignore: avoid_redundant_argument_values
  responseType: ResponseType.json,
);

Future<dynamic> getPosts() async {
  initInterceptors();

  final response = await dio.get<String>('/posts');
  if (response.statusCode == 200) {
    return response.data;
  }
  throw Exception('No 200 status code: Error code: ${response.statusCode}');
}

void initInterceptors() {
  dio.interceptors.add(
    InterceptorsWrapper(
      onError: (e, handler) {},
      onRequest: (options, handler) {
        debugPrint('Запрос отправляется');
        
        return handler.next(options);
      },
      onResponse: (e, handler) {
        debugPrint('Ответ получен');

        return handler.next(e);
      },
    ),
  );
}
