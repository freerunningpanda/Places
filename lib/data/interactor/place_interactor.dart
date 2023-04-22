import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:places/data/database/database.dart';
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
  static Set<DbPlace> newPlaces = {};
  final PlaceRepository repository;
  final controller = TextEditingController();
  String query = '';
  bool hasFocus = false;

  PlaceInteractor({
    required this.repository,
  });

  Future<List<DbPlace>> getPlaces() => repository.getPlaces();

  Future<DbPlace> getPlaceDetails(DbPlace place) => repository.getPlaceDetails(place);

  Future<String> postPlace({
    required DbPlace place,
    required List<XFile> urls,
  }) =>
      repository.postPlace(
        place: place,
        urls: urls,
      );

  Future<void> loadAllPlaces({required AppDb db}) => repository.loadAllPlaces(db);

  Future<void> loadFavoritePlaces({required AppDb db}) => repository.loadFavoritePlaces(db);

  Future<void> addToFavorites({required DbPlace place, required AppDb db}) =>
      repository.addToFavorites(place: place, db: db);

  Future<void> removeFromFavorites({required DbPlace place, required AppDb db}) =>
      repository.removeFromFavorites(place: place, db: db);

  void addNewPlace({required DbPlace place}) => repository.addNewPlace(place: place);
}
