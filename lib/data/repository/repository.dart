import 'package:flutter/foundation.dart';
import 'package:places/data/api/api_places.dart';
import 'package:places/data/dto/place_request.dart';
import 'package:places/data/dto/place_response.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/mapper.dart';

class Repository {
  static final List<Place> places = [];
  final ApiPlaces apiPlaces;

  Repository({
    required this.apiPlaces,
  });

  Future<List<Place>> getPlaces() async {
    final placesDto = await apiPlaces.getPlaces(
      category: '',
      radius: 15000,
    );
    final places = await _placesFromApiToUi(placesDto);

    return places;
  }

  Future<Place> getPlaceDetails(Place place) async {
    final placeDto = await apiPlaces.getPlaceDetails(place.id);
    final placeDetail = await _detailPlaceFromApiToUi(placeDto);

    return placeDetail;
  }

  Set<Place> getFavoritesPlaces() => apiPlaces.getFavoritesPlaces();

  void addToFavorites({required Place place}) {
    PlaceInteractor.favoritePlaces.add(place);
    debugPrint('🟡--------- Добавлено в избранное: ${PlaceInteractor.favoritePlaces}');
    debugPrint('🟡--------- Длина: ${PlaceInteractor.favoritePlaces.length}');
  }

  void removeFromFavorites({required Place place}) {
    PlaceInteractor.favoritePlaces.remove(place);
    debugPrint('🟡--------- Длина: ${PlaceInteractor.favoritePlaces.length}');
  }

  Set<Place> getVisitPlaces() {
    return PlaceInteractor.visitedPlaces;
  }

  void addToVisitingPlaces({required Place place}) {
    PlaceInteractor.visitedPlaces.add(place);
  }

  void addNewPlace({required Place place}) {
    PlaceInteractor.newPlaces.add(place);
  }

  // Преобразовать все места из Dto в места для UI
  Future<List<Place>> _placesFromApiToUi(List<PlaceResponse> apiPlaces) async {
    return apiPlaces.map(Mapper.placesFromApiToUi).toList();
  }

  // Преобразовать одно место из Dto в место для UI
  Future<Place> _detailPlaceFromApiToUi(PlaceRequest apiPlaces) async {
    return Mapper.detailPlaceFromApiToUi(apiPlaces);
  }
}
