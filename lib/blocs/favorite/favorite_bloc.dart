import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/database/database.dart';
import 'package:places/data/interactor/place_interactor.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(const IsNotFavoriteState(placeIndex: 0)) {
    on<FavoriteEvent>(
      (event, emit) {
        if (event.isFavorite) {
          // addToFavorites(place: event.place, db: event.db);
          addToFavorites(place: event.place);
          emit(
            IsFavoriteState(placeIndex: event.placeIndex),
          );
        } else {
          // removeFromFavorites(place: event.place, db: event.db);
          removeFromFavorites(place: event.place);
          emit(
            IsNotFavoriteState(placeIndex: event.placeIndex),
          );
        }
      },
    );
  }

  void addToFavorites({required DbPlace place}) {
    PlaceInteractor.favoritePlaces.add(place);
    debugPrint('🟡--------- Добавлено в избранное: ${PlaceInteractor.favoritePlaces}');
    debugPrint('🟡--------- Длина: ${PlaceInteractor.favoritePlaces.length}');
  }

  void removeFromFavorites({required DbPlace place}) {
    PlaceInteractor.favoritePlaces.remove(place);
    debugPrint('🟡--------- Длина: ${PlaceInteractor.favoritePlaces.length}');
  }

  // Future<void> addToFavorites({required DbPlace place, required AppDb db}) async {
  //   await db.addPlace(place);
  //   // interactor.favoritePlaces.add(place);
  // }

  // Future<void> removeFromFavorites({required DbPlace place, required AppDb db}) async {
  //   await db.deletePlace(place.id);
  //   // interactor.favoritePlaces.remove(place);
  // }

  Future<void> loadPlaces(AppDb db) async {
    PlaceInteractor.favoritePlaces = await db.allPlacesEntries;
    debugPrint('places_list: ${PlaceInteractor.favoritePlaces.length}');
  }
}
