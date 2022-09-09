import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:places/data/filters_table.dart';
import 'package:places/mocks.dart';

class FiltersSettings extends ChangeNotifier {
  final distance = (Mocks.endPoint - Mocks.startPoint).toInt();

  final List<String> activeFilters = [];

  int length = 0;

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

  void showCount() {
    for (final el in FiltersTable.filteredMocks) {
      final distance = Geolocator.distanceBetween(
        Mocks.mockLat,
        Mocks.mockLot,
        el.lat,
        el.lot,
      );
      if (distance >= Mocks.rangeValues.start && distance <= Mocks.rangeValues.end) {
        FiltersTable.filtersWithDistance.add(el);
        length = FiltersTable.filtersWithDistance.length;
        notifyListeners();
        for (final i in FiltersTable.filtersWithDistance) {
          debugPrint('🟡---------Найдены места: ${i.name}');
        }
      }
    }
    // if (isEnabled) {
    //   FiltersTable.filtersWithDistance.clear();
    //   length = FiltersTable.filtersWithDistance.length;
    //   debugPrint('🟡---------Length: $length');
    // }
  }
}
