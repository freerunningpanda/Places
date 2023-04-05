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

  Set<DbPlace> getFavoritesPlaces() => apiPlaces.getFavoritesPlaces();

  Stream<bool> addToFavorites({required DbPlace place}) async* {
    final interactor = PlaceInteractor(
      repository: PlaceRepository(
        apiPlaces: ApiPlaces(),
      ),
    );

    var isFavorite = place.isFavorite;
    if (isFavorite != null) {
      if (!isFavorite) {
        final list = interactor.favoritePlaces.add(place);
        debugPrint('🟡--------- Добавлено в избранное: ${interactor.favoritePlaces}');
        debugPrint('🟡--------- Длина: ${interactor.favoritePlaces.length}');
        isFavorite = true;
        yield list;
      } else {
        final list = interactor.favoritePlaces.remove(place);
        debugPrint('🟡--------- Длина: ${interactor.favoritePlaces.length}');
        isFavorite = false;
        yield list;
      }
    }
  }

  void removeFromFavorites({required Place place}) {
    final interactor = PlaceInteractor(
      repository: PlaceRepository(
        apiPlaces: ApiPlaces(),
      ),
    );

    interactor.favoritePlaces.remove(place);
    debugPrint('🟡--------- Длина: ${interactor.favoritePlaces.length}');
  }

  void addNewPlace({required Place place}) {
    PlaceInteractor.newPlaces.add(place);
  }
}
