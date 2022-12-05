import 'package:places/data/model/place.dart';
import 'package:places/data/model/place_dto.dart';

abstract class Mapper {
  static Place fromApi(PlaceDto place) => Place(
        id: place.id,
        lat: place.lat,
        lon: place.lon,
        name: place.name,
        urls: place.urls,
        placeType: place.placeType,
        description: place.description,
      );
}
