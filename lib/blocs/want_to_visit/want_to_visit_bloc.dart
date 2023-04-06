import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/database/database.dart';
import 'package:places/data/interactor/place_interactor.dart';

part 'want_to_visit_event.dart';
part 'want_to_visit_state.dart';

class WantToVisitBloc extends Bloc<VisitingScreenEvent, WantToVisitScreenState> {
  // final interactor = PlaceInteractor(
  //   repository: PlaceRepository(
  //     apiPlaces: ApiPlaces(),
  //   ),
  // );
  // final _db = AppDb();
  // List<DbPlace> favoritePlaces = [];

  WantToVisitBloc() : super(WantToVisitScreenEmptyState()) {
    on<AddToWantToVisitEvent>(
      (event, emit) async {
        // await addToFavorites(place: event.place, db: event.db);
        emit(
          WantToVisitScreenIsNotEmpty(
            placeIndex: event.placeIndex,
            favoritePlaces: PlaceInteractor.favoritePlaces.toSet(),
            length: PlaceInteractor.favoritePlaces.length,
          ),
        );
      },
    );
    on<RemoveFromWantToVisitEvent>((event, emit) async {
      // await removeFromFavorites(place: event.place, db: event.db);
      final updatedList = PlaceInteractor.favoritePlaces.where((element) => element.id != event.placeIndex).toList();
      emit(
        WantToVisitScreenIsNotEmpty(
          placeIndex: event.placeIndex,
          favoritePlaces: updatedList.toSet(),
          length: PlaceInteractor.favoritePlaces.length,
        ),
      );
    });
    on<DragCardOnWantToVisitEvent>((event, emit) {
      dragCard(event.places, event.oldIndex, event.newIndex);
      emit(
        WantToVisitAfterDragState(
          newIndex: event.newIndex,
          oldIndex: event.oldIndex,
          favoritePlaces: event.places,
        ),
      );
    });
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

  void dragCard(List<DbPlace> places, int oldIndex, int newIndex) {
    var modifiedIndex = newIndex;
    if (newIndex > oldIndex) modifiedIndex--;

    final place = places.removeAt(oldIndex);
    places.insert(modifiedIndex, place);
  }
}
