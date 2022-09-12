import 'package:flutter/material.dart';
import 'package:places/data/categories_table.dart';
import 'package:places/data/filters.dart';
import 'package:places/data/sight.dart';
import 'package:places/mocks.dart';

typedef VoidFuncString = void Function(String)?;

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

  List<Sight> sightList = Mocks.mocks;

  bool isDarkMode = false;

  bool isLat = false;

  bool hasFocus = false;

  bool isFocusOn = false;

  List<Sight> suggestions = [];

  void activeFocus({required bool isActive}) {
    // ignore: prefer-conditional-expressions
    if (isActive) {
      hasFocus = true;
    } else {
      hasFocus = false;
    }
    notifyListeners();
  }

  void searchSight(String query) {
    suggestions = Mocks.mocks.where((sight) {
      final sightTitle = sight.name.toLowerCase();
      final input = query.toLowerCase();

      return sightTitle.contains(input);
    }).toList();

    sightList = suggestions;
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
