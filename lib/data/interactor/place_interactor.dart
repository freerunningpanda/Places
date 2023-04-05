import 'package:flutter/cupertino.dart';
import 'package:places/data/database/database.dart';
import 'package:places/data/model/category.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/place_repository.dart';

class PlaceInteractor {
  static final List<Category> activeFilters = [];
  static final List<DbPlace> initialFilteredPlaces = [];
  static final List<String> searchHistoryList = [];
  static Set<DbPlace> filtersWithDistance = {};
  static List<DbPlace> foundedPlaces = PlaceInteractor.filtersWithDistance.toList();
  static Set<Place> newPlaces = {};
  final PlaceRepository repository;
  final controller = TextEditingController();
  Set<DbPlace> favoritePlaces = {};
  Set<DbPlace> visitedPlaces = {};
  String query = '';
  bool hasFocus = false;

  PlaceInteractor({
    required this.repository,
  });

  Future<List<DbPlace>> getPlaces() => repository.getPlaces();

  Future<DbPlace> getPlaceDetails(DbPlace place) => repository.getPlaceDetails(place);

  Set<DbPlace> getFavoritesPlaces() => repository.getFavoritesPlaces();

  Stream<bool> addToFavorites({required DbPlace place}) => repository.addToFavorites(place: place);

  void removeFromFavorites({required Place place}) => repository.removeFromFavorites(place: place);

  void addNewPlace({required Place place}) => repository.addNewPlace(place: place);
}
