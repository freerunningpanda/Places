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

}
