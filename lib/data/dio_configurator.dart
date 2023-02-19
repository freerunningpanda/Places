import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

const url = 'https://test-backend-flutter.surfstudio.ru';

final dio = Dio(baseoptions);

BaseOptions baseoptions = BaseOptions(
  baseUrl: url,
  connectTimeout: const Duration(milliseconds: 50000),
  receiveTimeout: const Duration(milliseconds: 50000),
  sendTimeout: const Duration(milliseconds: 50000),
  // ignore: avoid_redundant_argument_values
  responseType: ResponseType.json,
);

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
