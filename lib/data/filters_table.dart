import 'package:places/data/filters.dart';
import 'package:places/data/sight.dart';

import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';

class FiltersTable {
  static final List<Filters> filters = [
    Filters(title: AppString.hotel, assetName: AppAssets.hotel),
    Filters(title: AppString.restaurant, assetName: AppAssets.restaurant),
    Filters(title: AppString.particularPlace, assetName: AppAssets.particularPlace),
    Filters(title: AppString.park, assetName: AppAssets.park),
    Filters(title: AppString.museum, assetName: AppAssets.museum),
    Filters(title: AppString.cafe, assetName: AppAssets.cafe),
  ];
  static final List<String> activeFilters = [];

  static final List<Sight> filteredMocks = [];

  static final List<Sight> filtersWithDistance = [];
}
