import 'package:flutter/material.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/mocks.dart';

class ImageProvider extends ChangeNotifier {
  void pickImage() {
    if (PlaceInteractor.places.isEmpty) {
      PlaceInteractor.places.addAll(Mocks.pickedImage);
      notifyListeners();
    }
  }

  void removeImage(int index) {
    if (PlaceInteractor.places.isNotEmpty) {
      PlaceInteractor.places.removeAt(index);
      notifyListeners();
    }
  }
}
