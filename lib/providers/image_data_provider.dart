import 'package:flutter/material.dart';

import 'package:places/data/model/place.dart';
import 'package:places/ui/res/app_strings.dart';

// Переписать на блок, когда пройду тему с загрузкой изображений
// Сейчас это бутофория
class ImageDataProvider extends ChangeNotifier {
  static final List<Place> places = [];

  static List<Place> pickedImage = [
    Place(
      id: 27,
      name: 'Мытищинский парк',
      lat: 55.911397,
      lng: 37.740033,
      urls: ['https://pic.rutubelist.ru/video/39/09/390905576c021a02b5b57c374ba16621.jpg'],
      description: 'Мытищинский парк — центральный парк в одноименном городе Московской области.',
      placeType: AppString.park,
    ),
  ];

  void pickImage() {
    if (ImageDataProvider.places.isEmpty) {
      ImageDataProvider.places.addAll(ImageDataProvider.pickedImage);
      notifyListeners();
    }
  }

  void removeImage(int index) {
    if (ImageDataProvider.places.isNotEmpty) {
      ImageDataProvider.places.removeAt(index);
      notifyListeners();
    }
  }
}
