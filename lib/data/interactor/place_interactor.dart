import 'package:flutter/material.dart';

import 'package:places/data/api/api_places.dart';
import 'package:places/data/dto/place_request.dart';
import 'package:places/data/dto/place_response.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/repository.dart';
import 'package:places/mocks.dart';

class PlaceInteractor extends ChangeNotifier {
  static final List<Place> places = [];
  static Set<Place> favoritePlaces = {};
  static Set<Place> visitedPlaces = {};
  static Set<Place> newPlaces = {};

  final distance = (Mocks.endPoint - Mocks.startPoint).toInt();

  final ApiPlaceRepository apiPlaceRepository;

  bool isFocusOn = false;

  PlaceInteractor({
    required this.apiPlaceRepository,
  });

  Future<List<Place>> getPlaces() async {
    final placesDto = await apiPlaceRepository.getPlaces(
      category: '',
      radius: 15000,
    );
    final places = await _fromApiToUI(placesDto);

    return places;
  }

  Future<PlaceRequest> getPlaceDetails(Place place) async {
    final placeDto = await apiPlaceRepository.getPlaceDetails(place.id);

    return placeDto;
  }

  Set<Place> getFavoritesPlaces() => apiPlaceRepository.getFavoritesPlaces();

  void addToFavorites({required Place place}) => apiPlaceRepository.addToFavorites(place: place);

  void removeFromFavorites({required Place place}) => apiPlaceRepository.removeFromFavorites(place: place);

  Set<Place> getVisitPlaces() => apiPlaceRepository.getVisitPlaces();

  void addToVisitingPlaces({required Place place}) => apiPlaceRepository.addToVisitingPlaces(place: place);

  void addNewPlace({required Place place}) => apiPlaceRepository.addNewPlace(place: place);

// Преобразовать все места из Dto в места для UI
  Future<List<Place>> _fromApiToUI(List<PlaceResponse> apiPlaces) async {
    return apiPlaces.map(Repository.fromApi).toList();
  }
}
