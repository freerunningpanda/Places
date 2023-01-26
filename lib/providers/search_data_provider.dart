import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/mocks.dart';

class SearchDataProvider extends ChangeNotifier {

  bool hasFocus = false;

  void activeFocus({required bool isActive}) {
    // ignore: prefer-conditional-expressions
    if (isActive) {
      hasFocus = true;
    } else {
      hasFocus = false;
    }
    notifyListeners();
  }

  void searchPlaces(String query, TextEditingController controller) {
    if (PlaceInteractor.activeFilters.isEmpty) {
      for (final el in PlaceInteractor.filtersWithDistance) {
        final distance = Geolocator.distanceBetween(
          Mocks.mockLat,
          Mocks.mockLot,
          el.lat,
          el.lon,
        );
        if (distance >= Mocks.rangeValues.start && distance <= Mocks.rangeValues.end) {
          PlaceInteractor.filteredPlaces = PlaceInteractor.filtersWithDistance.where((sight) {
            final sightTitle = sight.name.toLowerCase();
            final input = query.toLowerCase();

            return sightTitle.contains(input);
          }).toList();
        }
      }
    } else if (PlaceInteractor.activeFilters.isNotEmpty) {
      for (final el in PlaceInteractor.filteredMocks) {
        final distance = Geolocator.distanceBetween(
          Mocks.mockLat,
          Mocks.mockLot,
          el.lat,
          el.lon,
        );
        if (distance >= Mocks.rangeValues.start && distance <= Mocks.rangeValues.end) {
          PlaceInteractor.filteredPlaces = PlaceInteractor.filtersWithDistance.where((sight) {
            final sightTitle = sight.name.toLowerCase();
            final input = query.toLowerCase();

            return sightTitle.contains(input);
          }).toList();
        }
      }
    }

    if (controller.text.isEmpty) {
      PlaceInteractor.filteredPlaces.clear();
      notifyListeners();
    }
    notifyListeners();
  }

    void saveSearchHistory(String value, TextEditingController controller) {
    if (controller.text.isEmpty) return;
    PlaceInteractor.searchHistoryList.add(value);
    notifyListeners();
  }

  void removeItemFromHistory(String index) {
    PlaceInteractor.searchHistoryList.remove(index);
    notifyListeners();
  }
}
