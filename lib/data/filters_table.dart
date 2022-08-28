import 'package:places/data/filters.dart';

import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';

class FiltersTable {
  static final List<Filters> filters = [
    Filters(category: AppString.hotel, assetName: AppAssets.hotel),
    Filters(category: AppString.restaurant, assetName: AppAssets.restaurant),
    Filters(category: AppString.particularPlace, assetName: AppAssets.particularPlace),
    Filters(category: AppString.park, assetName: AppAssets.park),
    Filters(category: AppString.museum, assetName: AppAssets.museum),
    Filters(category: AppString.cafe, assetName: AppAssets.cafe),
  ];
  static final List<String> activeFilters = [];
}
