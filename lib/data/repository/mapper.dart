import 'package:places/data/database/database.dart';
import 'package:places/data/dto/place_request.dart';
import 'package:places/data/dto/place_response.dart';

class Mapper {
  static DbPlace placesFromApiToUi(PlaceResponse place) {
    /// Для записи в БД сохраняю список картинок в строку
    final urlsString = place.urls.join('|');

    return DbPlace(
      id: place.id,
      lat: place.lat ?? 0,
      lng: place.lon ?? 0,
      name: place.name,
      urls: urlsString,
      placeType: place.placeType,
      description: place.description,
    );
  }

  static DbPlace detailPlaceFromApiToUi(PlaceRequest place) => DbPlace(
        id: place.id,
        lat: place.lat,
        lng: place.lng,
        name: place.name,
        urls: place.urls[0],
        placeType: place.placeType,
        description: place.description,
      );

  static Set<PlaceRequest> getFiltersWithDistance(Set<DbPlace> places) => places
      .map(
        (place) => PlaceRequest(
          id: place.id,
          lat: place.lat,
          lng: place.lng,
          name: place.name,
          urls: [place.urls],
          placeType: place.placeType,
          description: place.description,
        ),
      )
      .toSet();
}
