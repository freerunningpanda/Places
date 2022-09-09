import 'package:flutter/cupertino.dart';
import 'package:places/data/filters.dart';
import 'package:places/ui/res/app_strings.dart';

class CategoriesTable extends ChangeNotifier {
  static final List<Category> categories = [
    Category(title: AppString.cinema),
    Category(title: AppString.restaurant),
    Category(title: AppString.particularPlace),
    Category(title: AppString.theater),
    Category(title: AppString.museum),
    Category(title: AppString.cafe),
  ];

  static final List<String> chosenCategory = [];

    List<String> chooseCategory(int index) {
    final category = CategoriesTable.categories[index];
    final activeCategory = CategoriesTable.chosenCategory;
    var isEnabled = !CategoriesTable.categories[index].isEnabled;
    isEnabled = !isEnabled;
    if (!isEnabled) {
      activeCategory.add(category.title);
      category.isEnabled = true;

      notifyListeners();
    } else {
      activeCategory.removeLast();
      category.isEnabled = false;
      notifyListeners();
    }

    return activeCategory;
  }
}
