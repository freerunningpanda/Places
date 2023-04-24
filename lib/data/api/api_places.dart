import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime_type/mime_type.dart';
import 'package:places/data/dio_configurator.dart';
import 'package:places/data/dto/place_model.dart';
import 'package:places/data/dto/place_request.dart';
import 'package:places/data/dto/place_response.dart';
import 'package:places/data/exceptions/network_exception.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/app_strings.dart';

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

  Future<PlaceModel> postPlace({required PlaceModel place}) async {
    initInterceptors();
    try {
      final response = await dio.post<Map<String, dynamic>>(
        AppStrings.placePath,
        data: jsonEncode(place.toJson()),
      );
      final newPlace = PlaceModel.fromJson(
        response.data as Map<String, dynamic>,
      );

      return newPlace;
    } on DioError catch (e) {
      throw NetworkException(
        query: e.requestOptions.path,
        statusCode: e.error.toString(),
      );
    }
  }

  Future<String> uploadFile(XFile image) async {
    final filename = image.path.split('/').last;

    final mimeType = mime(filename);
    final mimee = mimeType?.split('/')[0];
    final type = mimeType?.split('/')[1];

    try {
      final formData = FormData.fromMap(<String, dynamic>{
        'image': await MultipartFile.fromFile(
          image.path,
          filename: filename,
          contentType: MediaType(mimee!, type!),
        ),
      });

      final response = await dio.post<String>(
        AppStrings.uploadFilePath,
        data: formData,
      );

      return '${AppStrings.baseUrl}/${response.headers['location']?.first}';
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
