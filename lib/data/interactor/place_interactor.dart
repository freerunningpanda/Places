import 'package:places/data/model/place.dart';
import 'package:places/data/model/place_dto.dart';
import 'package:places/data/repository/api_place_repository.dart';
import 'package:places/data/repository/mapper.dart';

class PlaceInteractor {
  final ApiPlaceRepository apiPlaceRepository;

  PlaceInteractor({
    required this.apiPlaceRepository,
  });

  Future<List<Place>> getPlaces(PlaceDto place) async {

    final placesDto = await ApiPlaceRepository().getPlaces(
      category: place.placeType,
      radius: place.distance.toInt(),
    );
    final places = await _fromApiToUI(placesDto);

    return places;
  }

  Future<PlaceDto> getPlaceDetails(PlaceDto place) async {
    return apiPlaceRepository.getPlaceDetails(place.id);
  }

  Future<List<Place>> _fromApiToUI(List<PlaceDto> apiPlaces) async {
    return apiPlaces.map(Mapper.fromApi).toList();
  }
}
