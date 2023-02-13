import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/blocs/visiting_screen/visiting_screen_event.dart';
import 'package:places/blocs/visiting_screen/visiting_screen_state.dart';
import 'package:places/data/api/api_places.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/repository/place_repository.dart';

class VisitingScreenBloc extends Bloc<VisitingScreenEvent, WantToVisitScreenState> {
  final placeInteractor = PlaceInteractor(
    repository: PlaceRepository(apiPlaces: ApiPlaces()),
  );

  VisitingScreenBloc() : super(WantToVisitScreenEmptyState()) {
    on<AddToWantToVisitEvent>(
      (event, emit) async {
        if (event.isFavorite) {
          emit(
            WantToVisitScreenIsNotEmpty(
              placeIndex: event.placeIndex,
              favoritePlaces: {event.place},
              length: event.length,
            ),
          );
        } else {
          emit(WantToVisitScreenEmptyState());
        }
      },
    );
  }
}
