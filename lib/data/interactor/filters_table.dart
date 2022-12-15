import 'package:places/data/model/filters.dart';
import 'package:places/domain/place_ui.dart';

import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/utils/place_type.dart';

class FiltersTable {
  static final List<Category> filters = [
    Category(title: AppString.hotel, assetName: AppAssets.hotel, placeType: PlaceType.hotel),
    Category(title: AppString.restaurant, assetName: AppAssets.restaurant, placeType: PlaceType.restaurant,),
    Category(title: AppString.particularPlace, assetName: AppAssets.particularPlace, placeType: PlaceType.other),
    Category(title: AppString.park, assetName: AppAssets.park, placeType: PlaceType.park),
    Category(title: AppString.museum, assetName: AppAssets.museum, placeType: PlaceType.museum),
    Category(title: AppString.cafe, assetName: AppAssets.cafe, placeType: PlaceType.cafe),
  ];
  static final List<String> activeFilters = [];

  static final List<PlaceUI> filteredMocks = [];

  static final Set<PlaceUI> filtersWithDistance = {};
}
