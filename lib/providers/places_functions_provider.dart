import 'package:flutter/material.dart';

import 'package:places/data/model/place.dart';

class PlacesFunctionsProvider extends ChangeNotifier {






  void dragCard(List<Place> sights, int oldIndex, int newIndex) {
    final sight = sights.removeAt(oldIndex);
    sights.insert(newIndex, sight);
    notifyListeners();
  }


}
