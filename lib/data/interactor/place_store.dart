
import 'package:places/domain/place_ui.dart';

abstract class PlaceStore {
  static Set<PlaceUI> favoritePlaces = {};
  static List<PlaceUI> visitedPlaces = [];
}
