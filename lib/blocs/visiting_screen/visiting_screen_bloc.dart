import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/api/api_places.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/place_repository.dart';

part 'visiting_screen_event.dart';
part 'visiting_screen_state.dart';

class VisitingScreenBloc extends Bloc<VisitingScreenEvent, WantToVisitScreenState> {
  final interactor = PlaceInteractor(
    repository: PlaceRepository(apiPlaces: ApiPlaces()),
  );

  VisitingScreenBloc() : super(WantToVisitScreenEmptyState()) {
    on<AddToWantToVisitEvent>(
      (event, emit) async {
        if (event.isFavorite) {
          addToFavorites(place: event.place);
          emit(
            WantToVisitScreenIsNotEmpty(
              placeIndex: event.placeIndex,
              favoritePlaces: interactor.favoritePlaces,
              length: interactor.favoritePlaces.length,
            ),
          );
        } else {
          removeFromFavorites(place: event.place);
          emit(
            WantToVisitScreenIsNotEmpty(
              placeIndex: event.placeIndex,
              favoritePlaces: interactor.favoritePlaces,
              length: interactor.favoritePlaces.length,
            ),
          );
        }
      },
    );
    on<FavoriteListIsEmpty>(
      (event, emit) => emit(
        WantToVisitScreenEmptyState(),
      ),
    );
    on<RemoveFromWantToVisitEvent>((event, emit) {
      removeFromFavorites(place: event.place);
      emit(
        WantToVisitScreenIsNotEmpty(
          placeIndex: event.placeIndex,
          favoritePlaces: interactor.favoritePlaces,
          length: interactor.favoritePlaces.length,
        ),
      );
    });
  }

  void addToFavorites({required Place place}) {
    interactor.favoritePlaces.add(place);

    debugPrint('🟡--------- Добавлено в избранное: ${interactor.favoritePlaces}');
    debugPrint('🟡--------- Длина: ${interactor.favoritePlaces.length}');
    // place.isFavorite = true;
  }

  void removeFromFavorites({required Place place}) {
    interactor.favoritePlaces.remove(place);
    debugPrint('🟡--------- Длина: ${interactor.favoritePlaces.length}');
    // place.isFavorite = false;
  }
}
