import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/api/api_places.dart';
import 'package:places/data/database/database.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/repository/place_repository.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final interactor = PlaceInteractor(
    repository: PlaceRepository(
      apiPlaces: ApiPlaces(),
    ),
  );
  FavoriteBloc() : super(const IsNotFavoriteState(placeIndex: 0, isFavorite: false)) {
    on<AddToFavoriteEvent>(
      (event, emit) {
        emit(
          IsFavoriteState(placeIndex: event.placeIndex),
        );
      },
    );
    on<RemoveFromFavoriteEvent>(
      (event, emit) {
        emit(
          IsNotFavoriteState(placeIndex: event.placeIndex, isFavorite: event.isFavorite),
        );
      },
    );
  }

  // void addToFavorites({required DbPlace place}) {
  //   PlaceInteractor.favoritePlaces.add(place);
  //   debugPrint('🟡--------- Добавлено в избранное: ${PlaceInteractor.favoritePlaces}');
  //   debugPrint('🟡--------- Длина: ${PlaceInteractor.favoritePlaces.length}');
  // }

  // void removeFromFavorites({required DbPlace place}) {
  //   PlaceInteractor.favoritePlaces.remove(place);
  //   debugPrint('🟡--------- Длина: ${PlaceInteractor.favoritePlaces.length}');
  // }

  // Future<void> addToFavorites({required DbPlace place, required AppDb db}) async {
  //   await db.addPlace(place);
  //   // interactor.favoritePlaces.add(place);
  // }

  // Future<void> removeFromFavorites({required DbPlace place, required AppDb db}) async {
  //   await db.deletePlace(place.id);
  //   // interactor.favoritePlaces.remove(place);
  // }

  // Future<void> loadPlaces(AppDb db) async {
  //   PlaceInteractor.favoritePlaces = await db.favoritePlacesEntries;
  //   debugPrint('places_list: ${PlaceInteractor.favoritePlaces.length}');
  // }
}
