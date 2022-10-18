import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:places/data/categories_table.dart';
import 'package:places/data/filters.dart';
import 'package:places/data/filters_table.dart';
import 'package:places/data/sight.dart';
import 'package:places/mocks.dart';

class AppSettings extends ChangeNotifier {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final searchController = TextEditingController();
  final latController = TextEditingController();
  final lotController = TextEditingController();
  final titleFocus = FocusNode();
  final latFocus = FocusNode();
  final lotFocus = FocusNode();
  final descriptionFocus = FocusNode();
  final searchFocus = FocusNode();
  final Set<String> searchHistoryList = {};
  final List<Sight> places = [];
  List<Sight> sightsToVisit = Mocks.sightsTovisit;
  List<Sight> visitedSights = Mocks.visitedSights;

  bool isDarkMode = false;

  bool isLat = false;

  bool hasFocus = false;

  bool isFocusOn = false;

  List<Sight> suggestions = FiltersTable.filtersWithDistance.toList();

  void dragCard(List<Sight> sights, int oldIndex, int newIndex) {
    final sight = sights.removeAt(oldIndex);
    sights.insert(newIndex, sight);
    notifyListeners();
  }

  void deleteSight(int index, List<Sight> sight) {
    sight.removeAt(index);
    notifyListeners();
  }

  void pickImage() {
    if (places.isEmpty) {
      places.addAll(Mocks.pickedImage);
      notifyListeners();
    }
  }

  void removeImage(int index) {
    if (places.isNotEmpty) {
      places.removeAt(index);
      notifyListeners();
    } 
  }

  void saveSearchHistory(String value, TextEditingController controller) {
    if (controller.text.isEmpty) return;
    searchHistoryList.add(value);
    notifyListeners();
  }

  void removeItemFromHistory(String index) {
    searchHistoryList.remove(index);
    notifyListeners();
  }

  void removeAllItemsFromHistory() {
    searchHistoryList.clear();
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

  void clearSight() {
    for (final el in FiltersTable.filteredMocks) {
      final distance = Geolocator.distanceBetween(
        Mocks.mockLat,
        Mocks.mockLot,
        el.lat,
        el.lot,
      );
      if (Mocks.rangeValues.start > distance || Mocks.rangeValues.end < distance) {
        FiltersTable.filtersWithDistance.clear();
      }
    }
  }

  void searchSight(String query, TextEditingController controller) {
    if (FiltersTable.activeFilters.isEmpty) {
      for (final el in FiltersTable.filtersWithDistance) {
        final distance = Geolocator.distanceBetween(
          Mocks.mockLat,
          Mocks.mockLot,
          el.lat,
          el.lot,
        );
        if (distance >= Mocks.rangeValues.start && distance <= Mocks.rangeValues.end) {
          suggestions = FiltersTable.filtersWithDistance.where((sight) {
            final sightTitle = sight.name.toLowerCase();
            final input = query.toLowerCase();

            return sightTitle.contains(input);
          }).toList();
        }
      }
    } else if (FiltersTable.activeFilters.isNotEmpty) {
      for (final el in FiltersTable.filteredMocks) {
        final distance = Geolocator.distanceBetween(
          Mocks.mockLat,
          Mocks.mockLot,
          el.lat,
          el.lot,
        );
        if (distance >= Mocks.rangeValues.start && distance <= Mocks.rangeValues.end) {
          suggestions = FiltersTable.filtersWithDistance.where((sight) {
            final sightTitle = sight.name.toLowerCase();
            final input = query.toLowerCase();

            return sightTitle.contains(input);
          }).toList();
        }
      }
    }

    if (controller.text.isEmpty) {
      suggestions.clear();
      notifyListeners();
    }
    notifyListeners();
  }

  bool switchTheme({required bool value}) {
    notifyListeners();

    return isDarkMode = value;
  }

  void clearCategory({required List<Category> activeCategories}) {
    for (final i in activeCategories) {
      i.isEnabled = false;
    }
    activeCategories.clear();
    notifyListeners();
  }

  List<Category> chooseCategory({
    required int index,
    required List<Category> categories,
    required List<Category> activeCategories,
  }) {
    final category = categories[index];
    final activeCategory = activeCategories;
    var isEnabled = !categories[index].isEnabled;
    isEnabled = !isEnabled;
    for (final i in categories) {
      if (!isEnabled) {
        activeCategory.add(category);
        category.isEnabled = true;
        i.isEnabled = false;
        activeCategory
          ..clear()
          ..add(category);
        debugPrint('🟡--------- Выбрана категория: ${category.title}');
        category.isEnabled = true;
        notifyListeners();
      } else {
        category.isEnabled = false;
        activeCategory.clear();
        notifyListeners();
      }
    }

    return activeCategory;
  }

  void tapOnLat() {
    isLat = true;
    notifyListeners();
  }

  void goToLat() {
    isLat = true;
    lotFocus.requestFocus();
    notifyListeners();
  }

  void tapOnLot() {
    isLat = false;
    notifyListeners();
  }

  void goToDescription() {
    isLat = false;
    descriptionFocus.requestFocus();
    notifyListeners();
  }

  void updateCategory() {
    CategoriesTable.chosenCategory.isEmpty;
  }
}
