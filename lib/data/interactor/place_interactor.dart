import 'package:places/data/model/place.dart';
import 'package:places/data/repository/repository.dart';

class PlaceInteractor {
  static final List<Place> places = [];
  static Set<Place> favoritePlaces = {};
  static Set<Place> visitedPlaces = {};
  static Set<Place> newPlaces = {};

  final Repository repository;

  PlaceInteractor({
    required this.repository,
  });

  Future<List<Place>> getPlaces() async => repository.getPlaces();

  Future<Place> getPlaceDetails(Place place) => repository.getPlaceDetails(place);

  Set<Place> getFavoritesPlaces() => repository.getFavoritesPlaces();

  void addToFavorites({required Place place}) => repository.addToFavorites(place: place);

  void removeFromFavorites({required Place place}) => repository.removeFromFavorites(place: place);

  Set<Place> getVisitPlaces() => repository.getVisitPlaces();

  void addToVisitingPlaces({required Place place}) => repository.addToVisitingPlaces(place: place);

  void addNewPlace({required Place place}) => repository.addNewPlace(place: place);
  
}
