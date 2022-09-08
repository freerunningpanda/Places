import 'package:places/data/filters.dart';
import 'package:places/data/sight.dart';

import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';

class FiltersTable {
  static final List<Category> filters = [
    Category(title: AppString.hotel, assetName: AppAssets.hotel),
    Category(title: AppString.restaurant, assetName: AppAssets.restaurant),
    Category(title: AppString.particularPlace, assetName: AppAssets.particularPlace),
    Category(title: AppString.park, assetName: AppAssets.park),
    Category(title: AppString.museum, assetName: AppAssets.museum),
    Category(title: AppString.cafe, assetName: AppAssets.cafe),
  ];
  static final List<String> activeFilters = [];

  static final List<Sight> filteredMocks = [];

  static final List<Sight> filtersWithDistance = [];
}
