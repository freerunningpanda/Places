import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:places/data/api/api_places.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/category.dart';
import 'package:places/data/model/place.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/utils/place_type.dart';

class PlacesFunctionsProvider extends ChangeNotifier {
  static final List<Category> filters = [
    Category(title: AppString.hotel, assetName: AppAssets.hotel, placeType: PlaceType.hotel),
    Category(
      title: AppString.restaurant,
      assetName: AppAssets.restaurant,
      placeType: PlaceType.restaurant,
    ),
    Category(title: AppString.particularPlace, assetName: AppAssets.particularPlace, placeType: PlaceType.other),
    Category(title: AppString.park, assetName: AppAssets.park, placeType: PlaceType.park),
    Category(title: AppString.museum, assetName: AppAssets.museum, placeType: PlaceType.museum),
    Category(title: AppString.cafe, assetName: AppAssets.cafe, placeType: PlaceType.cafe),
  ];

  static final Set<String> searchHistoryList = {};
  static final List<String> activeFilters = [];
  static final Set<Place> filtersWithDistance = {};
  static final List<Place> filteredMocks = [];

  List<Place> filteredPlaces = filtersWithDistance.toList();

  bool hasFocus = false;

  void saveSearchHistory(String value, TextEditingController controller) {
    if (controller.text.isEmpty) return;
    PlacesFunctionsProvider.searchHistoryList.add(value);
    notifyListeners();
  }

  void removeItemFromHistory(String index) {
    PlacesFunctionsProvider.searchHistoryList.remove(index);
    notifyListeners();
  }

  void removeAllItemsFromHistory() {
    PlacesFunctionsProvider.searchHistoryList.clear();
    notifyListeners();
  }

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
    if (activeFilters.isEmpty) {
      for (final el in filtersWithDistance) {
        final distance = Geolocator.distanceBetween(
          Mocks.mockLat,
          Mocks.mockLot,
          el.lat,
          el.lon,
        );
        if (distance >= Mocks.rangeValues.start && distance <= Mocks.rangeValues.end) {
          filteredPlaces = filtersWithDistance.where((sight) {
            final sightTitle = sight.name.toLowerCase();
            final input = query.toLowerCase();

            return sightTitle.contains(input);
          }).toList();
        }
      }
    } else if (activeFilters.isNotEmpty) {
      for (final el in filteredMocks) {
        final distance = Geolocator.distanceBetween(
          Mocks.mockLat,
          Mocks.mockLot,
          el.lat,
          el.lon,
        );
        if (distance >= Mocks.rangeValues.start && distance <= Mocks.rangeValues.end) {
          filteredPlaces = filtersWithDistance.where((sight) {
            final sightTitle = sight.name.toLowerCase();
            final input = query.toLowerCase();

            return sightTitle.contains(input);
          }).toList();
        }
      }
    }

    if (controller.text.isEmpty) {
      filteredPlaces.clear();
      notifyListeners();
    }
    notifyListeners();
  }

  void clearAllFilters() {
    filters.map((e) => e.isEnabled = false).toList();
    activeFilters.removeWhere((element) => true);
    filtersWithDistance.clear();
    notifyListeners();
  }

  List<String> saveFilters(int index) {
    final filters = PlacesFunctionsProvider.filters[index];
    final activeFilters = PlacesFunctionsProvider.activeFilters;
    var isEnabled = !PlacesFunctionsProvider.filters[index].isEnabled;
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

  void showCount({required List<Place> placeList}) {
    if (filteredMocks.isEmpty) {
      filtersWithDistance.clear();
      for (final el in placeList) {
        final distance = Geolocator.distanceBetween(
          Mocks.mockLat,
          Mocks.mockLot,
          el.lat,
          el.lon,
        );
        if (distance >= Mocks.rangeValues.start && distance <= Mocks.rangeValues.end) {
          filtersWithDistance.add(el);
          debugPrint('🟡---------Добавленные места: $filtersWithDistance');
          filtersWithDistance.length;
          notifyListeners();
          /* for (final i in FiltersTable.filtersWithDistance) {
          debugPrint('🟡---------Найдены места: ${i.name}');
        } */
        }
      }
    } else {
      filtersWithDistance.clear();
      for (final el in filteredMocks) {
        final distance = Geolocator.distanceBetween(
          Mocks.mockLat,
          Mocks.mockLot,
          el.lat,
          el.lon,
        );
        if (distance >= Mocks.rangeValues.start && distance <= Mocks.rangeValues.end) {
          filtersWithDistance.add(el);
          debugPrint('🟡---------Добавленные места: $filtersWithDistance');
          filtersWithDistance.length;
          notifyListeners();
          /* for (final i in FiltersTable.filtersWithDistance) {
          debugPrint('🟡---------Найдены места: ${i.name}');
        } */
        }
      }
    }
  }

  void clearSight({required List<Place> placeList}) {
    for (final el in placeList) {
      final distance = Geolocator.distanceBetween(
        Mocks.mockLat,
        Mocks.mockLot,
        el.lat,
        el.lon,
      );
      if (Mocks.rangeValues.start > distance || Mocks.rangeValues.end < distance) {
        filtersWithDistance.clear();
      }
    }
  }

  void deleteSight(int index, List<Place> sight) {
    PlaceInteractor(apiPlaceRepository: ApiPlaceRepository()).removeFromFavorites(
      place: sight[index],
    );
    notifyListeners();
  }

  void dragCard(List<Place> sights, int oldIndex, int newIndex) {
    final sight = sights.removeAt(oldIndex);
    sights.insert(newIndex, sight);
    notifyListeners();
  }
}
