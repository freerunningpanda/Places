import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final Place place;
  FavoriteBloc(this.place) : super(IsNotFavoriteState(isFavorite: false)) {
    on<FavoriteEvent>(
      (event, emit) {
        if (event.isFavorite) {
          addToFavorites(place: place);
          emit(
            IsFavoriteState(isFavorite: event.isFavorite),
          );
        } else {
          removeFromFavorites(place: place);
          emit(
            IsNotFavoriteState(isFavorite: event.isFavorite),
          );
        }
      },
    );
  }

  void addToFavorites({required Place place}) {
    PlaceInteractor.favoritePlaces.add(place);
    debugPrint('🟡--------- Добавлено в избранное: ${PlaceInteractor.favoritePlaces}');
    debugPrint('🟡--------- Длина: ${PlaceInteractor.favoritePlaces.length}');
    // place.isFavorite = true;
  }

  void removeFromFavorites({required Place place}) {
    PlaceInteractor.favoritePlaces.remove(place);
    debugPrint('🟡--------- Длина: ${PlaceInteractor.favoritePlaces.length}');
    // place.isFavorite = false;
  }
}
