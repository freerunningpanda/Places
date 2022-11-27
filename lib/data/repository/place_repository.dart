import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:places/data/model/place.dart';

const url = 'https://test-backend-flutter.surfstudio.ru';

final dio = Dio(baseoptions);

BaseOptions baseoptions = BaseOptions(
  baseUrl: url,
  connectTimeout: 5000,
  receiveTimeout: 5000,
  sendTimeout: 5000,
  // ignore: avoid_redundant_argument_values
  responseType: ResponseType.json,
);

class PlaceRepository {
  Future<List<Place>> getPlaces() async {
    initInterceptors();

    final response = await dio.get<String>('/place');
    if (response.statusCode == 200) {
      final dynamic placesListJson = jsonDecode(response.data ?? '');

      return (placesListJson as List<dynamic>)
          // ignore: avoid_annotating_with_dynamic
          .map((dynamic place) => Place.fromJson(place as Map<String, dynamic>))
          .toList();
    }
    throw Exception('No 200 status code: Error code: ${response.statusCode}');
  }
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
