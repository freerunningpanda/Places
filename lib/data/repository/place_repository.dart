import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/model/places_filter_request_dto.dart';
import 'package:places/mocks.dart';

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

  void getFilteredPlaces({required int radius, required String category, required List<Place> places}) {
    for (var i = 0; i <= places.length; i++) {
      final distance = Geolocator.distanceBetween(
        Mocks.mockLat,
        Mocks.mockLot,
        places[i].lat,
        places[i].lon,
      );

      if (distance >= radius && category == places[i].placeType) {
        Place(
          id: places[i].id,
          lat: places[i].lat,
          lon: places[i].lon,
          name: places[i].name,
          urls: places[i].urls,
          placeType: places[i].placeType,
          description: places[i].description,
        );
      } else {
        return;
      }
    }
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

  Future<List<Place>> postFilteredPlaces({required String category, required int radius}) async {
    initInterceptors();

    final distance = Geolocator.distanceBetween(
      Mocks.mockLat,
      Mocks.mockLot,
      55.910493,
      37.736423,
    );

    if (distance <= radius) {
      final response = await dio.post<String>(
        '/filtered_places',
        data: jsonEncode({
          'lat': 55.989198,
          'lng': 37.601605,
          'radius': radius.toDouble(),
          'typeFilter': ['other', 'park'],
          'nameFilter': category,
        }),
      );

      if (response.statusCode == 200) {
        final dynamic list = jsonDecode(response.data ?? '');

        // ignore: avoid_annotating_with_dynamic
        return (list as List<dynamic>).map((dynamic e) => Place.fromJson(e as Map<String, dynamic>)).toList();
      }
      throw Exception('No 200 status code: Error code: ${response.statusCode}');
    } else {
      return [];
    }
  }

  Future<String> postPlace() async {
    initInterceptors();

    final response = await dio.post<String>(
      '/place',
      data: jsonEncode(
        {
          // 'id': 4,
          'lat': 565407.77,
          'lng': 6547450.76,
          'name': 'Место',
          'urls': ['http://test.com'],
          'placeType': 'temple',
          'description': 'Описание!',
        },
      ),
    );
    if (response.statusCode == 200) {
      return response.data ?? '';
    }
    throw Exception('No 200 status code: Error code: ${response.statusCode}');
  }

  Future<String> putPlace(int id) async {
    initInterceptors();

    final response = await dio.put<String>(
      '/place/$id',
      data: jsonEncode(
        {
          'lat': 565407.77,
          'lng': 6547450.76,
          'name': 'Место!!!',
          'urls': ['http://example.com'],
          'placeType': 'temple',
          'description': 'Место',
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
