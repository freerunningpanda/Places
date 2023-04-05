import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/api/api_places.dart';
import 'package:places/data/database/database.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/repository/place_repository.dart';

part 'want_to_visit_event.dart';
part 'want_to_visit_state.dart';

class WantToVisitBloc extends Bloc<VisitingScreenEvent, WantToVisitScreenState> {
  final interactor = PlaceInteractor(
    repository: PlaceRepository(apiPlaces: ApiPlaces()),
  );
  // final _db = AppDb();

  WantToVisitBloc() : super(WantToVisitScreenEmptyState()) {
    on<AddToWantToVisitEvent>(
      (event, emit) async {
        addToFavorites(place: event.place);
        emit(
          WantToVisitScreenIsNotEmpty(
            placeIndex: event.placeIndex,
            favoritePlaces: interactor.favoritePlaces,
            length: interactor.favoritePlaces.length,
          ),
        );
      },
    );
    on<RemoveFromWantToVisitEvent>((event, emit) {
      removeFromFavorites(place: event.place, db: event.db);
      emit(
        WantToVisitScreenIsNotEmpty(
          placeIndex: event.placeIndex,
          favoritePlaces: interactor.favoritePlaces,
          length: interactor.favoritePlaces.length,
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

  void addToFavorites({required DbPlace place}) {
    interactor.favoritePlaces.add(place);
  }

  Future<void> removeFromFavorites({required DbPlace place, required AppDb db}) async {
    await db.deletePlace(place.id);
    // interactor.favoritePlaces.remove(place);
  }

  void dragCard(List<DbPlace> places, int oldIndex, int newIndex) {
    var modifiedIndex = newIndex;
    if (newIndex > oldIndex) modifiedIndex--;

    final place = places.removeAt(oldIndex);
    places.insert(modifiedIndex, place);
  }
}
