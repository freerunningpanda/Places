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
    debugPrint('🟡---------$activeFilters');
    debugPrint('🟡---------Элементов в списке: ${activeFilters.length}');

    return activeFilters;
  }

  void count() {
    if (FiltersTable.filtersWithDistance.isNotEmpty || FiltersTable.filtersWithDistance.isEmpty) {
      notifyListeners();
    }
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
        el.lon,
      );
      debugPrint('🟡---------Dist: $distance');
      if (distance >= Mocks.rangeValues.start && distance <= Mocks.rangeValues.end) {
        FiltersTable.filtersWithDistance.add(el);
        length = FiltersTable.filtersWithDistance.length;
        notifyListeners();
        debugPrint('🟡---------Length: $length');
        for (final i in FiltersTable.filtersWithDistance) {
          debugPrint('🟡---------Найдены места: ${i.name}');
        }
      }
    }
  }
}
