import 'dart:math';

import 'package:flutter/material.dart';

import 'package:places/data/filters_table.dart';
import 'package:places/mocks.dart';

class FiltersSettings extends ChangeNotifier {
  final distance = (Mocks.endPoint - Mocks.startPoint).toInt();

  final List<String> activeFilters = [];
  // Timer? _debounce;

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

  // ignore: long-parameter-list
  bool calculateDistance({
    required double startingPointLat,
    required double startingPointLon,
    required double checkPointLat,
    required double checkPointLon,
    required int distance,
  }) {
    const ky = 40000000 / 360;
    final kx = cos(pi * startingPointLat / 180) * ky;
    final dx = (startingPointLon - checkPointLon).abs() * kx;
    final dy = (startingPointLat - checkPointLat).abs() * ky;

    debugPrint('🟡---------kx: $kx dx: $dx dy: $dy');
    notifyListeners();

    return sqrt(dx * dx + dy * dy) < distance;
  }

  // RangeValues getValues(RangeValues values) {
  //   if (_debounce?.isActive ?? false) _debounce?.cancel();
  //   _debounce = Timer(const Duration(seconds: 1), () {
  //     Mocks.rangeValues = values;
  //     notifyListeners();
  //   });

  //   return Mocks.rangeValues;
  // }

  void count() {
    if (FiltersTable.filteredMocks.isNotEmpty) {
      notifyListeners();
    }
  }
}
