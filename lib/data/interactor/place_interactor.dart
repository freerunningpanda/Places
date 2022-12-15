import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:places/data/interactor/filters_table.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/model/place_dto.dart';
import 'package:places/data/repository/api_place_repository.dart';
import 'package:places/data/repository/mapper.dart';
import 'package:places/domain/place_ui.dart';
import 'package:places/mocks.dart';

class PlaceInteractor extends ChangeNotifier {
  static final Set<String> searchHistoryList = {};

  final distance = (Mocks.endPoint - Mocks.startPoint).toInt();

  final List<String> activeFilters = [];

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

  Set<PlaceUI> getFavoritesPlaces() => apiPlaceRepository.getFavoritesPlaces();

  void addToFavorites({required PlaceUI place}) => apiPlaceRepository.addToFavorites(place: place);

  void removeFromFavorites({required PlaceUI place}) => apiPlaceRepository.removeFromFavorites(place: place);

  Set<PlaceUI> getVisitPlaces() => apiPlaceRepository.getVisitPlaces();

  void addToVisitingPlaces({required PlaceUI place}) => apiPlaceRepository.addToVisitingPlaces(place: place);

  void addNewPlace({required PlaceUI place}) => apiPlaceRepository.addNewPlace(place: place);

  void clearAllFilters() {
    FiltersTable.filters.map((e) => e.isEnabled = false).toList();
    activeFilters.removeWhere((element) => true);
    FiltersTable.filtersWithDistance.clear();
    notifyListeners();
  }

  List<String> saveFilters(int index) {
    final filters = FiltersTable.filters[index];
    final activeFilters = FiltersTable.activeFilters;
    var isEnabled = !FiltersTable.filters[index].isEnabled;
    isEnabled = !isEnabled;
    if (!isEnabled) {
      activeFilters.add(filters.title);
      filters.isEnabled = true;

      notifyListeners();
    } else {
      activeFilters.removeLast();
      filters.isEnabled = false;
      notifyListeners();
    }

    return activeFilters;
  }

  void changeArea({required double start, required double end}) {
    Mocks.rangeValues = RangeValues(start, end);
    notifyListeners();
  }

  void showCount({required List<PlaceUI> placeList}) {
    if (FiltersTable.filteredMocks.isEmpty) {
      FiltersTable.filtersWithDistance.clear();
      for (final el in placeList) {
        final distance = Geolocator.distanceBetween(
          Mocks.mockLat,
          Mocks.mockLot,
          el.lat,
          el.lon,
        );
        if (distance >= Mocks.rangeValues.start && distance <= Mocks.rangeValues.end) {
          FiltersTable.filtersWithDistance.add(el);
          debugPrint('🟡---------Добавленные места: ${FiltersTable.filtersWithDistance}');
          FiltersTable.filtersWithDistance.length;
          notifyListeners();
          /* for (final i in FiltersTable.filtersWithDistance) {
          debugPrint('🟡---------Найдены места: ${i.name}');
        } */
        }
      }
    } else {
      FiltersTable.filtersWithDistance.clear();
      for (final el in FiltersTable.filteredMocks) {
        final distance = Geolocator.distanceBetween(
          Mocks.mockLat,
          Mocks.mockLot,
          el.lat,
          el.lon,
        );
        if (distance >= Mocks.rangeValues.start && distance <= Mocks.rangeValues.end) {
          FiltersTable.filtersWithDistance.add(el);
          debugPrint('🟡---------Добавленные места: ${FiltersTable.filtersWithDistance}');
          FiltersTable.filtersWithDistance.length;
          notifyListeners();
          /* for (final i in FiltersTable.filtersWithDistance) {
          debugPrint('🟡---------Найдены места: ${i.name}');
        } */
        }
      }
    }
  }

// Преобразовать все места из Dto в места для UI
  Future<List<PlaceUI>> _fromApiToUI(List<PlaceDto> apiPlaces) async {
    return apiPlaces.map(Mapper.fromApi).toList();
  }
}
