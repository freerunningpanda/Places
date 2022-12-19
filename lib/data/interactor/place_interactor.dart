import 'package:flutter/material.dart';
import 'package:places/data/api/api_places.dart';
import 'package:places/data/dto/place_request.dart';
import 'package:places/data/dto/place_response.dart';
import 'package:places/data/model/category.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/repository.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/utils/place_type.dart';

class PlaceInteractor extends ChangeNotifier {
  static final List<Category> chosenCategory = [];
  static final List<Category> categories = [
    Category(title: AppString.hotel, placeType: PlaceType.hotel),
    Category(title: AppString.restaurant, placeType: PlaceType.restaurant),
    Category(title: AppString.particularPlace, placeType: PlaceType.other),
    Category(title: AppString.theater, placeType: PlaceType.park),
    Category(title: AppString.museum, placeType: PlaceType.museum),
    Category(title: AppString.cafe, placeType: PlaceType.cafe),
  ];

  static Set<Place> favoritePlaces = {};
  static Set<Place> visitedPlaces = {};
  static Set<Place> newPlaces = {};

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

  final List<Place> places = [];

  bool isLat = false;

  bool isFocusOn = false;

  PlaceInteractor({
    required this.apiPlaceRepository,
  });

  Future<List<Place>> getPlaces() async {
    final placesDto = await apiPlaceRepository.getPlaces(
      category: '',
      radius: 15000,
    );
    final places = await _fromApiToUI(placesDto);

    return places;
  }

  Future<PlaceRequest> getPlaceDetails(Place place) async {
    final placeDto = await apiPlaceRepository.getPlaceDetails(place.id);

    return placeDto;
  }

  Set<Place> getFavoritesPlaces() => apiPlaceRepository.getFavoritesPlaces();

  void addToFavorites({required Place place}) => apiPlaceRepository.addToFavorites(place: place);

  void removeFromFavorites({required Place place}) => apiPlaceRepository.removeFromFavorites(place: place);

  Set<Place> getVisitPlaces() => apiPlaceRepository.getVisitPlaces();

  void addToVisitingPlaces({required Place place}) => apiPlaceRepository.addToVisitingPlaces(place: place);

  void addNewPlace({required Place place}) => apiPlaceRepository.addNewPlace(place: place);

  void changeArea({required double start, required double end}) {
    Mocks.rangeValues = RangeValues(start, end);
    notifyListeners();
  }

  void dragCard(List<Place> sights, int oldIndex, int newIndex) {
    final sight = sights.removeAt(oldIndex);
    sights.insert(newIndex, sight);
    notifyListeners();
  }

  void deleteSight(int index, List<Place> sight) {
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
  Future<List<Place>> _fromApiToUI(List<PlaceResponse> apiPlaces) async {
    return apiPlaces.map(Repository.fromApi).toList();
  }
}
