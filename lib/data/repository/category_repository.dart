import 'package:places/data/model/category.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/utils/place_type.dart';

class CategoryRepository {
  static final List<Category> chosenCategories = [];
  static final List<Category> categories = [
    Category(title: AppStrings.hotel, placeType: PlaceType.hotel),
    Category(title: AppStrings.restaurant, placeType: PlaceType.restaurant),
    Category(title: AppStrings.particularPlace, placeType: PlaceType.other),
    Category(title: AppStrings.theater, placeType: PlaceType.park),
    Category(title: AppStrings.museum, placeType: PlaceType.museum),
    Category(title: AppStrings.cafe, placeType: PlaceType.cafe),
  ];
}
