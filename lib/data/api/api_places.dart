import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:places/data/database/database.dart';
import 'package:places/data/dio_configurator.dart';
import 'package:places/data/dto/place_request.dart';
import 'package:places/data/dto/place_response.dart';
import 'package:places/data/exceptions/network_exception.dart';
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

  Future<String> postPlace({required DbPlace place, required List<XFile> urls}) async {
    initInterceptors();
    try {
      // Create a new FormData object to store the request data
      final formData = FormData();

      // Add the place data to the FormData object
      formData.fields.addAll([
        MapEntry('lat', place.lat.toString()),
        MapEntry('lng', place.lng.toString()),
        MapEntry('name', place.name),
        MapEntry('placeType', place.placeType),
        MapEntry('description', place.description),
      ]);

      // Convert the list of XFile images to MultipartFile objects and add them to the FormData object
      final files = <MultipartFile>[];
      for (final url in urls) {
        files.add(await MultipartFile.fromFile(url.path, filename: basename(url.path)));
      }
      for (final file in files) {
        formData.files.add(
          MapEntry('urls', file),
        );
      }

      final response = await dio.post<String>(
        '/place',
        data: formData,
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

  // Future<String> postPlace({required DbPlace place, required List<XFile> urls}) async {
  //   initInterceptors();
  //   try {
  //     final formData = FormData.fromMap(<String, dynamic>{
  //       'lat': place.lat,
  //       'lng': place.lng,
  //       'name': place.name,
  //       'placeType': place.placeType,
  //       'description': 'Тест загрузки',
  //     });

  //     // Добавить изображения в form data
  //     for (var i = 0; i < urls.length; i++) {
  //     final file = await urls[i].readAsBytes();
  //     formData.files.add(MapEntry(
  //         'urls[]',
  //         MultipartFile.fromBytes(
  //             file,
  //             filename: '${place.name}_$i',
  //         ),
  //     ));
  //   }
  //     final response = await dio.post<String>(
  //       '/place',
  //       data: formData,
  //     );
  //     if (response.statusCode == 200) {
  //       return response.data ?? '';
  //     }
  //     throw Exception('No 200 status code: Error code: ${response.statusCode}');
  //   } on DioError catch (e) {
  //     throw NetworkException(
  //       query: e.requestOptions.path,
  //       statusCode: e.error.toString(),
  //     );
  //   }
  // }

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
