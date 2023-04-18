import 'package:flutter/foundation.dart';
import 'package:places/data/api/api_places.dart';
import 'package:places/data/database/database.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/mapper.dart';

class PlaceRepository {
  static final List<Place> places = [];
  final ApiPlaces apiPlaces;

  PlaceRepository({
    required this.apiPlaces,
  });

  // Преобразовать все места из Dto в места для UI
  // Получить реальные места
  Future<List<DbPlace>> getPlaces() async {
    final places = await apiPlaces.getPlaces(
      category: '',
      radius: 15000,
    );

    return places.map(Mapper.placesFromApiToUi).toList();
  }

  // Получить моковые места
  // Future<List<Place>> getPlaces() async {
  //   final places = Mocks.mocks;

  //   return places;
  // }

  // Преобразовать одно место из Dto в место для UI
  Future<DbPlace> getPlaceDetails(DbPlace place) =>
      apiPlaces.getPlaceDetails(place.id).then(Mapper.detailPlaceFromApiToUi);

  List<DbPlace> getFavoritesPlaces() => apiPlaces.getFavoritesPlaces();

  Future<void> removeFromFavorites({required DbPlace place, required AppDb db}) async {
   await db.deletePlace(place);
  }

  Future<void> addToFavorites({required DbPlace place, required AppDb db}) async {
    await db.addPlaceToFavorites(place, isSearchScreen: false);
  }

   Future<void> loadFavoritePlaces(AppDb db) async {
    PlaceInteractor.favoritePlaces = await db.favoritePlacesEntries;
    debugPrint('places_list: ${PlaceInteractor.favoritePlaces.length}');
  }

   Future<void> loadAllPlaces(AppDb db) async {
    PlaceInteractor.favoritePlaces = await db.allPlacesEntries;
    debugPrint('places_list: ${PlaceInteractor.favoritePlaces.length}');
  }

  void addNewPlace({required Place place}) {
    PlaceInteractor.newPlaces.add(place);
  }
}