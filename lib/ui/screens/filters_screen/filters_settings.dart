import 'dart:math';

import 'package:flutter/material.dart';

import 'package:places/data/filters_table.dart';
import 'package:places/mocks.dart';

class FiltersSettings extends ChangeNotifier {
  final List<String> activeFilters = [];

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
  bool isNear({
    required double startingPointLat,
    required double startingPointLon,
    required double checkPointLat,
    required double checkPointLon,
    required int distance,
  }) {
    var ky = 40000000 / 360;
    var kx = cos(pi * startingPointLat / 180) * ky;
    var dx = (startingPointLon - checkPointLon).abs() * kx;
    var dy = (startingPointLat - checkPointLat).abs() * ky;

    return sqrt(dx * dx + dy * dy) < distance;
  }
}
