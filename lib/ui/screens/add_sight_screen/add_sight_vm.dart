
import 'package:flutter/material.dart';

import 'package:places/data/api/api_places.dart';
import 'package:places/data/interactor/place_interactor.dart';

import 'package:places/data/repository/place_repository.dart';


// WM для AddSightScreen
class AddSightWidgetModel {
  final placeIntertor = PlaceInteractor(
    repository: PlaceRepository(
      apiPlaces: ApiPlaces(),
    ),
  );


}

class ViewModel extends ChangeNotifier {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final searchController = TextEditingController();
  final latController = TextEditingController();
  final lotController = TextEditingController();
  final titleFocus = FocusNode();
  final searchFocus = FocusNode();
  final descriptionFocus = FocusNode();
  final latFocus = FocusNode();
  final lotFocus = FocusNode();
  bool isLat = false;

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
}
