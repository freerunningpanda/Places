import 'package:flutter/cupertino.dart';
import 'package:places/data/model/filters.dart';
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

  static final List<Category> chosenCategory = [];
}
