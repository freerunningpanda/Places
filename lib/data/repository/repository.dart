import 'package:flutter/foundation.dart';
import 'package:places/data/api/api_places.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/mapper.dart';

class Repository {
  static final List<Place> places = [];
  final ApiPlaces apiPlaces;

  Repository({
    required this.apiPlaces,
  });

  // Преобразовать все места из Dto в места для UI
  Future<List<Place>> getPlaces() async {
    final places = await apiPlaces.getPlaces(
      category: '',
      radius: 15000,
    );

    return places.map(Mapper.placesFromApiToUi).toList();
  }

  // Преобразовать одно место из Dto в место для UI
  Future<Place> getPlaceDetails(Place place) => apiPlaces.getPlaceDetails(place.id).then(Mapper.detailPlaceFromApiToUi);

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
}
