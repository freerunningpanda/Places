import 'package:places/data/model/place.dart';
import 'package:places/data/model/place_dto.dart';
import 'package:places/data/repository/api_place_repository.dart';
import 'package:places/data/repository/mapper.dart';
import 'package:places/domain/place_ui.dart';

class PlaceInteractor {
  final ApiPlaceRepository apiPlaceRepository;

  PlaceInteractor({
    required this.apiPlaceRepository,
  });

  Future<List<PlaceUI>> getPlaces() async {
    final placesDto = await apiPlaceRepository.getPlaces(
      category: '',
      radius: 15000,
    );
    final places = await _fromApiToUI(placesDto);

    return places;
  }

  Future<Place> getPlaceDetails(PlaceUI place) async {
    final placeDto = await apiPlaceRepository.getPlaceDetails(place.id);

    return placeDto;
  }

  void getFavoritesPlaces() => apiPlaceRepository.getFavoritesPlaces();

  void addToFavorites({required PlaceUI place}) => apiPlaceRepository.addToFavorites(place: place);

  void removeFromFavorites({required PlaceUI place}) => apiPlaceRepository.removeFromFavorites(place: place);

  List<PlaceUI> getVisitPlaces() => apiPlaceRepository.getVisitPlaces();

  void addToVisitingPlaces({required PlaceUI place}) => apiPlaceRepository.addToVisitingPlaces(place: place);

  void addNewPlace({required PlaceUI place}) => apiPlaceRepository.addNewPlace(place: place);

// Преобразовать все места из Dto в места для UI
  Future<List<PlaceUI>> _fromApiToUI(List<PlaceDto> apiPlaces) async {
    return apiPlaces.map(Mapper.fromApi).toList();
  }
}
