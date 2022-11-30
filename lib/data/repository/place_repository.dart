import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/model/places_filter_request_dto.dart';

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
  Future<List<PlacesFilterRequestDto>> getPlaces() async {
    initInterceptors();

    final response = await dio.get<String>('/place');
    if (response.statusCode == 200) {
      final dynamic placesListJson = jsonDecode(response.data ?? '');

      return (placesListJson as List<dynamic>)
          // ignore: avoid_annotating_with_dynamic
          .map((dynamic place) => PlacesFilterRequestDto.fromJson(place as Map<String, dynamic>))
          .toList();
    }
    throw Exception('No 200 status code: Error code: ${response.statusCode}');
  }

  Future<Place> getPlace(int id) async {
    initInterceptors();

    final response = await dio.get<String>('/place/$id');
    if (response.statusCode == 200) {
      final dynamic placesListJson = jsonDecode(response.data ?? '');

      return Place.fromJson(placesListJson as Map<String, dynamic>);
    }
    throw Exception('No 200 status code: Error code: ${response.statusCode}');
  }

  Future<String> postFilteredPlaces() async {
    initInterceptors();

    final response = await dio.post<String>(
      '/filtered_places',
      data: jsonEncode(
        {
          'lat': null,
          'lng': null,
          'radius': null,
          'typeFilter': ['other', 'park'],
          'nameFilter': '',
        },
      ),
    );
    if (response.statusCode == 200) {
      return response.data ?? '';
    }
    throw Exception('No 200 status code: Error code: ${response.statusCode}');
  }

  Future<String> postPlace() async {
    initInterceptors();

    final response = await dio.post<String>(
      '/place',
      data: jsonEncode(
        {
          'id': 3,
          'lat': 565407.77,
          'lng': 6547450.76,
          'name': 'Уряяяя!!!',
          'urls': ['http://example.com'],
          'placeType': 'temple',
          'description': 'Я сделяль запрос в сеть!',
        },
      ),
    );
    if (response.statusCode == 200) {
      return response.data ?? '';
    }
    throw Exception('No 200 status code: Error code: ${response.statusCode}');
  }

  Future<String> deletePlace(int id) async {
    initInterceptors();

    final response = await dio.delete<String>(
      '/place/$id',
    );
    if (response.statusCode == 200) {
      return response.data ?? '';
    }
    throw Exception('No 200 status code: Error code: ${response.statusCode}');
  }

  Future<String> post() async {
    // initInterceptors();

    final response = await dio.post<String>(
      'https://jsonplaceholder.typicode.com/posts',
      data: jsonEncode(
        {
          'userId': 1,
          'id': 5433,
          'title': '',
          'body': '',
        },
      ),
    );
    if (response.statusCode == 201) {
      return response.data ?? '';
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
