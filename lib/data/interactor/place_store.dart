import 'package:places/data/model/place.dart';

abstract class PlaceStore {
  static List<Place> favoritePlaces = [];
  static List<Place> visitedPlaces = [];
}
