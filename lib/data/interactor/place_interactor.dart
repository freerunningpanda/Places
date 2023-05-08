import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:places/data/database/database.dart';
import 'package:places/data/dto/place_model.dart';
import 'package:places/data/model/category.dart';
import 'package:places/data/repository/place_repository.dart';

class PlaceInteractor {
  static final List<Category> activeFilters = [];
  static final List<DbPlace> initialFilteredPlaces = [];
  static final List<String> searchHistoryList = [];
  static final List<XFile> urls = [];
  static List<DbPlace> favoritePlaces = [];
  static List<DbPlace> visitedPlaces = [];
  static Set<DbPlace> filtersWithDistance = {};
  static List<DbPlace> foundedPlaces = PlaceInteractor.filtersWithDistance.toList();
  static List<DbPlace> savedPlaces = [];
  final PlaceRepository repository;
  final controller = TextEditingController();
  String query = '';
  bool hasFocus = false;

  PlaceInteractor({
    required this.repository,
  });

  Future<List<DbPlace>> getPlaces() => repository.getPlaces();

  Future<List<DbPlace>> getPlacesNoGeo() => repository.getPlacesNoGeo();

  Future<DbPlace> getPlaceDetails(DbPlace place) => repository.getPlaceDetails(place);

  Future<PlaceModel> postPlace({
    required PlaceModel place,
  }) =>
      repository.postPlace(
        place: place,
      );
  Future<String> uploadFile(XFile image) => repository.uploadFile(image);

  Future<void> loadAllPlaces({required AppDb db}) => repository.loadAllPlaces(db);

  Future<void> loadFavoritePlaces({required AppDb db}) => repository.loadFavoritePlaces(db);

  Future<void> addToFavorites({required DbPlace place, required AppDb db}) =>
      repository.addToFavorites(place: place, db: db);

  Future<void> removeFromFavorites({required DbPlace place, required AppDb db}) =>
      repository.removeFromFavorites(place: place, db: db);

  Future<String> deletePlace(int id) => repository.deletePlace(id);

}
