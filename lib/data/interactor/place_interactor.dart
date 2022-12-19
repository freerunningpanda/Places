import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:places/data/api/api_place_repository.dart';
import 'package:places/data/api/mapper.dart';
import 'package:places/data/model/filters.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/model/place_dto.dart';
import 'package:places/domain/place_ui.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/utils/place_type.dart';

class PlaceInteractor extends ChangeNotifier {
    static final List<Category> filters = [
    Category(title: AppString.hotel, assetName: AppAssets.hotel, placeType: PlaceType.hotel),
    Category(title: AppString.restaurant, assetName: AppAssets.restaurant, placeType: PlaceType.restaurant,),
    Category(title: AppString.particularPlace, assetName: AppAssets.particularPlace, placeType: PlaceType.other),
    Category(title: AppString.park, assetName: AppAssets.park, placeType: PlaceType.park),
    Category(title: AppString.museum, assetName: AppAssets.museum, placeType: PlaceType.museum),
    Category(title: AppString.cafe, assetName: AppAssets.cafe, placeType: PlaceType.cafe),
  ];

  static final List<PlaceUI> filteredMocks = [];
  static final List<String> activeFilters = [];


  static final Set<PlaceUI> filtersWithDistance = {};
  
  static final Set<String> searchHistoryList = {};
  static final List<Category> chosenCategory = [];
  static final List<Category> categories = [
    Category(title: AppString.hotel, placeType: PlaceType.hotel),
    Category(title: AppString.restaurant, placeType: PlaceType.restaurant),
    Category(title: AppString.particularPlace, placeType: PlaceType.other),
    Category(title: AppString.theater, placeType: PlaceType.park),
    Category(title: AppString.museum, placeType: PlaceType.museum),
    Category(title: AppString.cafe, placeType: PlaceType.cafe),
  ];

  static Set<PlaceUI> favoritePlaces = {};
  static Set<PlaceUI> visitedPlaces = {};
  static Set<PlaceUI> newPlaces = {};


  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final searchController = TextEditingController();
  final latController = TextEditingController();
  final lotController = TextEditingController();
  final titleFocus = FocusNode();
  final latFocus = FocusNode();
  final lotFocus = FocusNode();
  final descriptionFocus = FocusNode();
  final searchFocus = FocusNode();

  final distance = (Mocks.endPoint - Mocks.startPoint).toInt();


  final ApiPlaceRepository apiPlaceRepository;

  final List<PlaceUI> places = [];

  bool isLat = false;

  bool hasFocus = false;

  bool isFocusOn = false;

  List<PlaceUI> suggestions = filtersWithDistance.toList();

  PlaceInteractor({
    required this.apiPlaceRepository,
  });

  Future<List<PlaceUI>> getPlaces() async {
    final placesDto = await apiPlaceRepository.getPlaces(
      category: '',
      radius: 15000,
    );
    final places = await _fromApiToUI(placesDto);

    return places;
  }

  Future<Place> getPlaceDetails(PlaceUI place) async {
    final placeDto = await apiPlaceRepository.getPlaceDetails(place.id);

    return placeDto;
  }

  Set<PlaceUI> getFavoritesPlaces() => apiPlaceRepository.getFavoritesPlaces();

  void addToFavorites({required PlaceUI place}) => apiPlaceRepository.addToFavorites(place: place);

  void removeFromFavorites({required PlaceUI place}) => apiPlaceRepository.removeFromFavorites(place: place);

  Set<PlaceUI> getVisitPlaces() => apiPlaceRepository.getVisitPlaces();

  void addToVisitingPlaces({required PlaceUI place}) => apiPlaceRepository.addToVisitingPlaces(place: place);

  void addNewPlace({required PlaceUI place}) => apiPlaceRepository.addNewPlace(place: place);

  void clearAllFilters() {
    filters.map((e) => e.isEnabled = false).toList();
    activeFilters.removeWhere((element) => true);
    filtersWithDistance.clear();
    notifyListeners();
  }

  List<String> saveFilters(int index) {
    final filters = PlaceInteractor.filters[index];
    final activeFilters = PlaceInteractor.activeFilters;
    var isEnabled = !PlaceInteractor.filters[index].isEnabled;
    isEnabled = !isEnabled;
    if (!isEnabled) {
      activeFilters.add(filters.title);
      filters.isEnabled = true;

      notifyListeners();
    } else {
      activeFilters.removeLast();
      filters.isEnabled = false;
      notifyListeners();
    }

    return activeFilters;
  }

  void changeArea({required double start, required double end}) {
    Mocks.rangeValues = RangeValues(start, end);
    notifyListeners();
  }

  void showCount({required List<PlaceUI> placeList}) {
    if (filteredMocks.isEmpty) {
      filtersWithDistance.clear();
      for (final el in placeList) {
        final distance = Geolocator.distanceBetween(
          Mocks.mockLat,
          Mocks.mockLot,
          el.lat,
          el.lon,
        );
        if (distance >= Mocks.rangeValues.start && distance <= Mocks.rangeValues.end) {
          filtersWithDistance.add(el);
          debugPrint('🟡---------Добавленные места: $filtersWithDistance');
          filtersWithDistance.length;
          notifyListeners();
          /* for (final i in FiltersTable.filtersWithDistance) {
          debugPrint('🟡---------Найдены места: ${i.name}');
        } */
        }
      }
    } else {
      filtersWithDistance.clear();
      for (final el in filteredMocks) {
        final distance = Geolocator.distanceBetween(
          Mocks.mockLat,
          Mocks.mockLot,
          el.lat,
          el.lon,
        );
        if (distance >= Mocks.rangeValues.start && distance <= Mocks.rangeValues.end) {
          filtersWithDistance.add(el);
          debugPrint('🟡---------Добавленные места: $filtersWithDistance');
          filtersWithDistance.length;
          notifyListeners();
          /* for (final i in FiltersTable.filtersWithDistance) {
          debugPrint('🟡---------Найдены места: ${i.name}');
        } */
        }
      }
    }
  }

  void dragCard(List<PlaceUI> sights, int oldIndex, int newIndex) {
    final sight = sights.removeAt(oldIndex);
    sights.insert(newIndex, sight);
    notifyListeners();
  }

  void deleteSight(int index, List<PlaceUI> sight) {
    PlaceInteractor(apiPlaceRepository: ApiPlaceRepository()).removeFromFavorites(
      place: sight[index],
    );
    notifyListeners();
  }

  void pickImage() {
    if (places.isEmpty) {
      places.addAll(Mocks.pickedImage);
      notifyListeners();
    }
  }

  void removeImage(int index) {
    if (places.isNotEmpty) {
      places.removeAt(index);
      notifyListeners();
    }
  }

  void saveSearchHistory(String value, TextEditingController controller) {
    if (controller.text.isEmpty) return;
    PlaceInteractor.searchHistoryList.add(value);
    notifyListeners();
  }

  void removeItemFromHistory(String index) {
    PlaceInteractor.searchHistoryList.remove(index);
    notifyListeners();
  }

  void removeAllItemsFromHistory() {
    PlaceInteractor.searchHistoryList.clear();
    notifyListeners();
  }

  void activeFocus({required bool isActive}) {
    // ignore: prefer-conditional-expressions
    if (isActive) {
      hasFocus = true;
    } else {
      hasFocus = false;
    }
    notifyListeners();
  }

  void clearSight({required List<PlaceUI> placeList}) {
    for (final el in placeList) {
      final distance = Geolocator.distanceBetween(
        Mocks.mockLat,
        Mocks.mockLot,
        el.lat,
        el.lon,
      );
      if (Mocks.rangeValues.start > distance || Mocks.rangeValues.end < distance) {
        filtersWithDistance.clear();
      }
    }
  }

  void searchPlaces(String query, TextEditingController controller) {
    if (activeFilters.isEmpty) {
      for (final el in filtersWithDistance) {
        final distance = Geolocator.distanceBetween(
          Mocks.mockLat,
          Mocks.mockLot,
          el.lat,
          el.lon,
        );
        if (distance >= Mocks.rangeValues.start && distance <= Mocks.rangeValues.end) {
          suggestions = filtersWithDistance.where((sight) {
            final sightTitle = sight.name.toLowerCase();
            final input = query.toLowerCase();

            return sightTitle.contains(input);
          }).toList();
        }
      }
    } else if (activeFilters.isNotEmpty) {
      for (final el in filteredMocks) {
        final distance = Geolocator.distanceBetween(
          Mocks.mockLat,
          Mocks.mockLot,
          el.lat,
          el.lon,
        );
        if (distance >= Mocks.rangeValues.start && distance <= Mocks.rangeValues.end) {
          suggestions = filtersWithDistance.where((sight) {
            final sightTitle = sight.name.toLowerCase();
            final input = query.toLowerCase();

            return sightTitle.contains(input);
          }).toList();
        }
      }
    }

    if (controller.text.isEmpty) {
      suggestions.clear();
      notifyListeners();
    }
    notifyListeners();
  }

  void clearCategory({required List<Category> activeCategories}) {
    for (final i in activeCategories) {
      i.isEnabled = false;
    }
    activeCategories.clear();
    notifyListeners();
  }

  List<Category> chooseCategory({
    required int index,
    required List<Category> categories,
    required List<Category> activeCategories,
  }) {
    final category = categories[index];
    final activeCategory = activeCategories;
    var isEnabled = !categories[index].isEnabled;
    isEnabled = !isEnabled;
    for (final i in categories) {
      if (!isEnabled) {
        activeCategory.add(category);
        category.isEnabled = true;
        i.isEnabled = false;
        activeCategory
          ..clear()
          ..add(category);
        debugPrint('🟡--------- Выбрана категория: ${category.title}');
        category.isEnabled = true;
        notifyListeners();
      } else {
        category.isEnabled = false;
        activeCategory.clear();
        notifyListeners();
      }
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

  void updateCategory() {
    chosenCategory.isEmpty;
  }

// Преобразовать все места из Dto в места для UI
  Future<List<PlaceUI>> _fromApiToUI(List<PlaceDto> apiPlaces) async {
    return apiPlaces.map(Mapper.fromApi).toList();
  }
}
