import 'package:mobx/mobx.dart';
import 'package:places/data/api/api_places.dart';
import 'package:places/data/model/place.dart';

import 'package:places/data/repository/place_repository.dart';

part 'place_list_store.g.dart';

class PlaceListStore = PlaceListStoreBase with _$PlaceListStore;

abstract class PlaceListStoreBase with Store {
  final PlaceRepository _placeRepository;

  @observable
  ObservableFuture<List<Place>> getPlacesFuture = ObservableFuture(
    PlaceRepository(
      apiPlaces: ApiPlaces(),
    ).getPlaces(),
  );

  PlaceListStoreBase({
    required PlaceRepository placeRepository,
  }) : _placeRepository = placeRepository;

  @action
  Future<void> getPlaces({bool isHidden = false}) async {
    final future = _placeRepository.getPlaces();

    if (isHidden) {
      final res = await future;
      getPlacesFuture = ObservableFuture.value(res);
    } else {
      getPlacesFuture = ObservableFuture(future);
    }
  }
}
