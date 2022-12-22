import 'package:flutter/material.dart';
import 'package:places/data/api/api_places.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/place_repository.dart';

class DismissibleDataProvider extends ChangeNotifier {
  
  void deleteSight(int index, List<Place> sight) {
    PlaceInteractor(repository: PlaceRepository(apiPlaces: ApiPlaces())).removeFromFavorites(
      place: sight[index],
    );
    notifyListeners();
  }

    void dragCard(List<Place> sights, int oldIndex, int newIndex) {
    final sight = sights.removeAt(oldIndex);
    sights.insert(newIndex, sight);
    notifyListeners();
  }
}
