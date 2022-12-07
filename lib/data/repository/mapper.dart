import 'package:places/data/model/place_dto.dart';
import 'package:places/domain/place_ui.dart';

abstract class Mapper {
  static PlaceUI fromApi(PlaceDto place) => PlaceUI(
        id: place.id,
        lat: place.lat,
        lon: place.lon,
        name: place.name,
        urls: place.urls,
        placeType: place.placeType,
        description: place.description,
      );
}
