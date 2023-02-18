import 'package:flutter/cupertino.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/place_repository.dart';

class PlaceInteractor {
  static final List<String> activeFilters = [];
  static final Set<Place> filtersWithDistance = {};
  static final List<Place> filteredMocks = [];
  static final Set<String> searchHistoryList = {};
  static List<Place> filteredPlaces = filtersWithDistance.toList();
  static Set<Place> newPlaces = {};
  final PlaceRepository repository;
  final controller = TextEditingController();
  Set<Place> favoritePlaces = {};
  Set<Place> visitedPlaces = {};
  String query = '';
  bool hasFocus = false;

  PlaceInteractor({
    required this.repository,
  });

  Future<List<Place>> getPlaces() => repository.getPlaces();

  Future<Place> getPlaceDetails(Place place) => repository.getPlaceDetails(place);

  Set<Place> getFavoritesPlaces() => repository.getFavoritesPlaces();

  Stream<bool> addToFavorites({required Place place}) => repository.addToFavorites(place: place);

  void removeFromFavorites({required Place place}) => repository.removeFromFavorites(place: place);

  void addNewPlace({required Place place}) => repository.addNewPlace(place: place);
}
