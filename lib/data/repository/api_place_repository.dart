import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:places/data/interactor/place_store.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/model/place_dto.dart';
import 'package:places/domain/place_ui.dart';
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

class ApiPlaceRepository {
  Future<List<PlaceDto>> getPlaces({required String category, required int radius}) async {
    initInterceptors();

    final response = await dio.post<String>(
      '/filtered_places',
      data: jsonEncode({
        'lat': Mocks.mockLat,
        'lng': Mocks.mockLot,
        'radius': radius.toDouble(),
        'typeFilter': ['park', 'museum', 'other', 'theatre'],
        'nameFilter': category,
      }),
    );

    if (response.statusCode == 200) {
      final dynamic list = jsonDecode(response.data ?? '');
      debugPrint('$list');

      // ignore: avoid_annotating_with_dynamic
      return (list as List<dynamic>).map((dynamic e) => PlaceDto.fromJson(e as Map<String, dynamic>)).toList();
    }
    throw Exception('No 200 status code: Error code: ${response.statusCode}');
  }

  Future<Place> getPlaceDetails(int id) async {
    initInterceptors();

    final response = await dio.get<String>('/place/$id');
    if (response.statusCode == 200) {
      final dynamic placesListJson = jsonDecode(response.data ?? '');

      return Place.fromJson(placesListJson as Map<String, dynamic>);
    }
    throw Exception('No 200 status code: Error code: ${response.statusCode}');
  }

  Set<PlaceUI> getFavoritesPlaces() {
    return PlaceStore.favoritePlaces;
  }

  void addToFavorites({required PlaceUI place}) {
    final list = PlaceStore.favoritePlaces.add(place);
    debugPrint('🟡--------- Добавлено в избранное: ${PlaceStore.favoritePlaces}');
    debugPrint('🟡--------- Длина: ${PlaceStore.favoritePlaces.length}');
  }

  void removeFromFavorites({required PlaceUI place}) {
    PlaceStore.favoritePlaces.remove(place);
  }

  Set<PlaceUI> getVisitPlaces() {
    return PlaceStore.visitedPlaces;
  }

  void addToVisitingPlaces({required PlaceUI place}) {
    PlaceStore.visitedPlaces.add(place);
  }

  void addNewPlace({required PlaceUI place}) {
    PlaceStore.visitedPlaces.remove(place);
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
