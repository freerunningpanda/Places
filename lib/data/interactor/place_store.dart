
import 'package:places/domain/place_ui.dart';

abstract class PlaceStore {
  static Set<PlaceUI> favoritePlaces = {};
  static Set<PlaceUI> visitedPlaces = {};
  static Set<PlaceUI> newPlaces = {};
}
