import 'package:places/data/database/database.dart';
import 'package:places/data/dto/place_request.dart';
import 'package:places/data/dto/place_response.dart';

class Mapper {
  static DbPlace placesFromApiToUi(PlaceResponse place) => DbPlace(
        id: place.id,
        lat: place.lat,
        lng: place.lon,
        name: place.name,
        urls: place.urls[0],
        placeType: place.placeType,
        description: place.description,
        isFavorite: false,
      );

  static DbPlace detailPlaceFromApiToUi(PlaceRequest place) => DbPlace(
        id: place.id,
        lat: place.lat,
        lng: place.lng,
        name: place.name,
        urls: place.urls[0],
        placeType: place.placeType,
        description: place.description,
        isFavorite: false,
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

  // static Place getPlaceFromDb(DbPlace place) => Place(
  //       id: place.id,
  //       lat: place.lat,
  //       lng: place.lng,
  //       name: place.name,
  //       urls: place.urls,
  //       placeType: place.placeType,
  //       description: place.description,
  //     );
}
