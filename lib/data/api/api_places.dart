import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:places/data/dio_configurator.dart';
import 'package:places/data/dto/place_request.dart';
import 'package:places/data/dto/place_response.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/mocks.dart';



class ApiPlaces {
  Future<List<PlaceResponse>> getPlaces({required String category, required int radius}) async {
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
      return (list as List<dynamic>).map((dynamic e) => PlaceResponse.fromJson(e as Map<String, dynamic>)).toList();
    }
    throw Exception('No 200 status code: Error code: ${response.statusCode}');
  }

  Future<PlaceRequest> getPlaceDetails(int id) async {
    initInterceptors();

    final response = await dio.get<String>('/place/$id');
    if (response.statusCode == 200) {
      final dynamic placesListJson = jsonDecode(response.data ?? '');

      return PlaceRequest.fromJson(placesListJson as Map<String, dynamic>);
    }
    throw Exception('No 200 status code: Error code: ${response.statusCode}');
  }

  Set<Place> getFavoritesPlaces() {
    return PlaceInteractor.favoritePlaces;
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

