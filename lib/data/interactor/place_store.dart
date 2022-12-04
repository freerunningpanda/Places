import 'package:places/data/model/place_dto.dart';

abstract class PlaceStore {
  static List<PlaceDto> favoritePlaces = [];
  static List<PlaceDto> visitedPlaces = [];
}
