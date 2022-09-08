import 'package:places/data/filters.dart';
import 'package:places/ui/res/app_strings.dart';


class CategoriesTable {
  static final List<Category> categories = [
    Category(title: AppString.cinema),
    Category(title: AppString.restaurant),
    Category(title: AppString.particularPlace),
    Category(title: AppString.theater),
    Category(title: AppString.museum),
    Category(title: AppString.cafe),
  ];
}
