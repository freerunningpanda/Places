
import 'package:places/domain/place_ui.dart';

abstract class PlaceStore {
  static List<PlaceUI> favoritePlaces = [];
  static List<PlaceUI> visitedPlaces = [];
}
