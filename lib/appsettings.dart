import 'package:flutter/material.dart';
import 'package:places/data/filters.dart';

typedef VoidFuncString = void Function(String)?;

class AppSettings extends ChangeNotifier {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final latController = TextEditingController();
  final lotController = TextEditingController();
  final titleFocus = FocusNode();
  final latFocus = FocusNode();
  final lotFocus = FocusNode();
  final descriptionFocus = FocusNode();

  bool isDarkMode = false;

  bool isLat = false;

  bool switchTheme({required bool value}) {
    notifyListeners();

    return isDarkMode = value;
  }

  List<String> chooseCategory({
    required int index,
    required List<Category> categories,
    required List<String> activeCategories,
  }) {
    final category = categories[index];
    final activeCategory = activeCategories;
    var isEnabled = !categories[index].isEnabled;
    isEnabled = !isEnabled;
    if (!isEnabled) {
      activeCategory.add(category.title);
      category.isEnabled = true;
      if (activeCategories.length > 1) {
        activeCategory
          ..clear()
          ..add(category.title);
      }
      notifyListeners();
    } else {
      category.isEnabled = false;
      activeCategory.clear();
      notifyListeners();
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
}
