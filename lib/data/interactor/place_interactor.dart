import 'package:places/data/model/place.dart';
import 'package:places/data/model/place_dto.dart';
import 'package:places/data/repository/api_place_repository.dart';
import 'package:places/data/repository/mapper.dart';

class PlaceInteractor {
  final ApiPlaceRepository apiPlaceRepository;

  PlaceInteractor({
    required this.apiPlaceRepository,
  });

  Future<List<Place>> getPlaces() async {
    final placesDto = await apiPlaceRepository.getPlaces(
      category: 'park',
      radius: 15000,
    );
    final places = await _fromApiToUI(placesDto);

    return places;
  }

  Future<Place> getPlaceDetails(PlaceDto place) async {
    final placeDto = await apiPlaceRepository.getPlaceDetails(place.id);

    final placeDetail = await _fromApiToUIPlace(placeDto);

    return placeDetail;
  }

  void getFavoritesPlaces() => apiPlaceRepository.getFavoritesPlaces();

  void addToFavorites({required Place place}) => apiPlaceRepository.addToFavorites(place: place);

  void removeFromFavorites({required Place place}) => apiPlaceRepository.removeFromFavorites(place: place);

  List<Place> getVisitPlaces() => apiPlaceRepository.getVisitPlaces();

  void addToVisitingPlaces({required Place place}) => apiPlaceRepository.addToVisitingPlaces(place: place);

  void addNewPlace({required Place place}) => apiPlaceRepository.addNewPlace(place: place);

// Преобразовать все места из Dto в места для UI
  Future<List<Place>> _fromApiToUI(List<PlaceDto> apiPlaces) async {
    return apiPlaces.map(Mapper.fromApi).toList();
  }

// Преобразовать одно место из Dto в UI
  Future<Place> _fromApiToUIPlace(PlaceDto place) async {
    return Mapper.fromApi(place);
  }
}
