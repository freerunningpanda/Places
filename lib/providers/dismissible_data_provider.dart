import 'package:flutter/material.dart';
import 'package:places/data/api/api_places.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/place_repository.dart';

class DismissibleDataProvider extends ChangeNotifier {
  final interactor = PlaceInteractor(
    repository: PlaceRepository(apiPlaces: ApiPlaces()),
  );
  // void deleteSight(int index, List<Place> sightsToVisit) {
  //   debugPrint('🟡--------- Длина перед удалением: ${sightsToVisit.length}');
  //   debugPrint('🟡--------- Место удалено: $sightsToVisit');
  //   sightsToVisit.removeAt(index);
  //   debugPrint('🟡--------- Длина после удаления: ${sightsToVisit.length}');
  //   notifyListeners();
  // }

  // void dragCard(List<Place> sights, int oldIndex, int newIndex) {
  //   if (oldIndex < newIndex) {
  //     newIndex -= 1;
  //   }

  //   final place = sights.removeAt(oldIndex);
  //   sights.insert(newIndex, place);
  //   notifyListeners();
  // }
  void deleteSight({required Place place}) {
    interactor.favoritePlaces.remove(place);
    debugPrint('🟡--------- Длина: ${interactor.favoritePlaces.length}');
    notifyListeners();
  }

  void dragCard(List<Place> sights, int oldIndex, int newIndex) {
    final sight = sights.removeAt(oldIndex);
    sights.insert(newIndex, sight);
    notifyListeners();
  }
}
