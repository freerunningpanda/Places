import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:places/data/api/api_places.dart';
import 'package:places/data/database/database.dart';
import 'package:places/data/dto/place_model.dart';
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
      radius: 10000,
    );

    return places.map(Mapper.placesFromApiToUi).toList();
  }

  // Получить все места если в гео было отказано пользователем
  Future<List<DbPlace>> getPlacesNoGeo() async {
    final places = await apiPlaces.getPlacesNoGeo(
      category: '',
    );

    return places.map(Mapper.placesFromApiToUi).toList();
  }

  // Получить моковые места
  // Future<List<Place>> getPlaces() async {
  //   final places = Mocks.mocks;

  //   return places;
  // }

  // Загрузить место на сервер
  Future<PlaceModel> postPlace({
    required PlaceModel place,
  }) =>
      apiPlaces.postPlace(
        place: place,
      );

  // Загрузить фото на сервер
  Future<String> uploadFile(XFile image) => apiPlaces.uploadFile(image);

  // Преобразовать одно место из Dto в место для UI
  Future<DbPlace> getPlaceDetails(DbPlace place) =>
      apiPlaces.getPlaceDetails(place.id).then(Mapper.detailPlaceFromApiToUi);

  Future<void> removeFromFavorites({required DbPlace place, required AppDb db}) async {
    await db.deletePlace(place);
  }

  Future<void> addToFavorites({
    required DbPlace place,
    required AppDb db,
    required bool isVisited,
  }) async {
    await db.addPlace(
      place,
      isSearchScreen: false,
      id: place.id,
      isVisited: isVisited,
    );
  }

  Future<void> loadFavoritePlaces(AppDb db) async {
    PlaceInteractor.favoritePlaces = await db.favoritePlacesEntries;
    debugPrint('places_list: ${PlaceInteractor.favoritePlaces.length}');
  }

  Future<void> loadAllPlaces(AppDb db) async {
    PlaceInteractor.favoritePlaces = await db.allPlacesEntries;
    debugPrint('places_list: ${PlaceInteractor.favoritePlaces.length}');
  }

  Future<String> deletePlace(int id) => apiPlaces.deletePlace(id);
}
