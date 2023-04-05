import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/api/api_places.dart';
import 'package:places/data/database/database.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/place_repository.dart';

part 'visited_screen_event.dart';
part 'visited_screen_state.dart';

class VisitedScreenBloc extends Bloc<VisitedScreenEvent, VisitedScreenState> {
  final interactor = PlaceInteractor(
    repository: PlaceRepository(apiPlaces: ApiPlaces()),
  );

  VisitedScreenBloc() : super(VisitedEmptyState()) {
    on<AddToVisitedEvent>(
      (event, emit) async {
        addToVisited(place: event.place);
        emit(
          VisitedIsNotEmpty(
            placeIndex: event.placeIndex,
            visitedPlaces: interactor.favoritePlaces,
            length: interactor.favoritePlaces.length,
          ),
        );
      },
    );
    on<RemoveFromVisitedEvent>((event, emit) {
      removeFromVisited(place: event.place);
      emit(
        VisitedIsNotEmpty(
          placeIndex: event.placeIndex,
          visitedPlaces: interactor.favoritePlaces,
          length: interactor.favoritePlaces.length,
        ),
      );
    });
    on<DragCardOnVisitedEvent>((event, emit) {
      dragCard(event.places, event.oldIndex, event.newIndex);
      emit(
        VisitedAfterDragState(
          newIndex: event.newIndex,
          oldIndex: event.oldIndex,
          favoritePlaces: event.places,
        ),
      );
    });
  }

  void addToVisited({required DbPlace place}) {
    interactor.visitedPlaces.add(place);
  }

  void removeFromVisited({required Place place}) {
    interactor.visitedPlaces.remove(place);
  }

  void dragCard(List<DbPlace> places, int oldIndex, int newIndex) {
    var modifiedIndex = newIndex;
    if (newIndex > oldIndex) modifiedIndex--;

    final place = places.removeAt(oldIndex);
    places.insert(modifiedIndex, place);
  }
}
