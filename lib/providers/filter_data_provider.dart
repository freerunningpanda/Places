import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/category.dart';
import 'package:places/data/model/place.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/utils/place_type.dart';

class FilterDataProvider extends ChangeNotifier {


  // void clearAllFilters() {
  //   filters.map((e) => e.isEnabled = false).toList();
  //   PlaceInteractor.activeFilters.removeWhere((element) => true);
  //   PlaceInteractor.filtersWithDistance.clear();
  //   notifyListeners();
  // }

  // List<String> saveFilters(int index) {
  //   final filters = FilterDataProvider.filters[index];
  //   final activeFilters = PlaceInteractor.activeFilters;
  //   var isEnabled = !FilterDataProvider.filters[index].isEnabled;
  //   isEnabled = !isEnabled;
  //   if (!isEnabled) {
  //     activeFilters.add(filters.title);
  //     filters.isEnabled = true;

  //     notifyListeners();
  //   } else {
  //     activeFilters.removeLast();
  //     filters.isEnabled = false;
  //     notifyListeners();
  //   }

  //   return activeFilters;
  // }

  // void showCount({required List<Place> places}) {
  //   if (PlaceInteractor.initialFilteredPlaces.isEmpty) {
  //     PlaceInteractor.filtersWithDistance.clear();
  //     for (final el in places) {
  //       final distance = Geolocator.distanceBetween(
  //         Mocks.mockLat,
  //         Mocks.mockLot,
  //         el.lat,
  //         el.lng,
  //       );
  //       if (distance >= Mocks.rangeValues.start && distance <= Mocks.rangeValues.end) {
  //         PlaceInteractor.filtersWithDistance.add(el);
  //         debugPrint('🟡---------Добавленные места: ${PlaceInteractor.filtersWithDistance}');
  //         PlaceInteractor.filtersWithDistance.length;
  //         notifyListeners();
  //         /* for (final i in FiltersTable.filtersWithDistance) {
  //         debugPrint('🟡---------Найдены места: ${i.name}');
  //       } */
  //       }
  //     }
  //   } else {
  //     PlaceInteractor.filtersWithDistance.clear();
  //     for (final el in PlaceInteractor.initialFilteredPlaces) {
  //       final distance = Geolocator.distanceBetween(
  //         Mocks.mockLat,
  //         Mocks.mockLot,
  //         el.lat,
  //         el.lng,
  //       );
  //       if (distance >= Mocks.rangeValues.start && distance <= Mocks.rangeValues.end) {
  //         PlaceInteractor.filtersWithDistance.add(el);
  //         debugPrint('🟡---------Добавленные места: ${PlaceInteractor.filtersWithDistance}');
  //         PlaceInteractor.filtersWithDistance.length;
  //         notifyListeners();
  //         /* for (final i in FiltersTable.filtersWithDistance) {
  //         debugPrint('🟡---------Найдены места: ${i.name}');
  //       } */
  //       }
  //     }
  //   }
  // }

  // void changeArea({required double start, required double end}) {
  //   Mocks.rangeValues = RangeValues(start, end);
  //   notifyListeners();
  // }

  // void clearSight({required List<Place> places}) {
  //   for (final el in places) {
  //     final distance = Geolocator.distanceBetween(
  //       Mocks.mockLat,
  //       Mocks.mockLot,
  //       el.lat,
  //       el.lng,
  //     );
  //     if (Mocks.rangeValues.start > distance || Mocks.rangeValues.end < distance) {
  //       PlaceInteractor.filtersWithDistance.clear();
  //     }
  //   }
  // }
}
