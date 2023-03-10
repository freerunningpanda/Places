import 'package:places/data/model/category.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/utils/place_type.dart';

class CategoryRepository {
  static final List<Category> chosenCategories = [];
  static final List<Category> categories = [
    Category(title: AppString.hotel, placeType: PlaceType.hotel),
    Category(title: AppString.restaurant, placeType: PlaceType.restaurant),
    Category(title: AppString.particularPlace, placeType: PlaceType.other),
    Category(title: AppString.theater, placeType: PlaceType.park),
    Category(title: AppString.museum, placeType: PlaceType.museum),
    Category(title: AppString.cafe, placeType: PlaceType.cafe),
  ];
}
