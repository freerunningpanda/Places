import 'package:flutter/material.dart';

import 'package:places/data/filters_table.dart';

class FiltersSettings extends ChangeNotifier {
  static RangeValues rangeValues = const RangeValues(2000, 8000);

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
    } 
    else {
      activeFilters.removeLast();
      filters.isEnabled = false;
      notifyListeners();
    }
    debugPrint('$activeFilters');
    debugPrint('Элементов в списке: ${activeFilters.length}');

    return activeFilters;
  }
}
