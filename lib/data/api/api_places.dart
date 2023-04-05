import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:places/data/database/database.dart';
import 'package:places/data/dio_configurator.dart';
import 'package:places/data/dto/place_request.dart';
import 'package:places/data/dto/place_response.dart';
import 'package:places/data/exceptions/network_exception.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/mocks.dart';

class ApiPlaces {
  Future<List<PlaceResponse>> getPlaces({required String category, required int radius}) async {
    initInterceptors();

    try {
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
        return (list as List<dynamic>).map((dynamic e) => PlaceResponse.fromJson(e as Map<String, dynamic>)).toList();
      }
      throw Exception('No 200 status code: Error code: ${response.statusCode}');
    } on DioError catch (e) {
      throw NetworkException(
        query: e.requestOptions.path,
        statusCode: e.error.toString(),
      );
    }
  }

  Future<PlaceRequest> getPlaceDetails(int id) async {
    initInterceptors();
    try {
      final response = await dio.get<String>('/place/$id');
      if (response.statusCode == 200) {
        final dynamic placesListJson = jsonDecode(response.data ?? '');

        return PlaceRequest.fromJson(placesListJson as Map<String, dynamic>);
      }
      throw Exception('No 200 status code: Error code: ${response.statusCode}');
    } on DioError catch (e) {
      throw NetworkException(
        query: e.requestOptions.path,
        statusCode: e.error.toString(),
      );
    }
  }

  Set<DbPlace> getFavoritesPlaces() {
    final interactor = PlaceInteractor(
      repository: PlaceRepository(
        apiPlaces: ApiPlaces(),
      ),
    );

    return interactor.favoritePlaces;
  }

  Future<String> postPlace() async {
    initInterceptors();
    try {
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
            'description': 'Описание',
          },
        ),
      );
      if (response.statusCode == 200) {
        return response.data ?? '';
      }
      throw Exception('No 200 status code: Error code: ${response.statusCode}');
    } on DioError catch (e) {
      throw NetworkException(
        query: e.requestOptions.path,
        statusCode: e.error.toString(),
      );
    }
  }

  Future<String> putPlace(int id) async {
    initInterceptors();
    try {
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
    } on DioError catch (e) {
      throw NetworkException(
        query: e.requestOptions.path,
        statusCode: e.error.toString(),
      );
    }
  }

  Future<String> deletePlace(int id) async {
    initInterceptors();
    try {
      final response = await dio.delete<String>(
        '/place/$id',
      );
      if (response.statusCode == 200) {
        return response.data ?? '';
      }
      throw Exception('No 200 status code: Error code: ${response.statusCode}');
    } on DioError catch (e) {
      throw NetworkException(
        query: e.requestOptions.path,
        statusCode: e.error.toString(),
      );
    }
  }
}
