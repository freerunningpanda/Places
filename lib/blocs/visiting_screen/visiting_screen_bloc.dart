import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/blocs/visiting_screen/visiting_screen_event.dart';
import 'package:places/blocs/visiting_screen/visiting_screen_state.dart';
import 'package:places/data/api/api_places.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/repository/place_repository.dart';

class VisitingScreenBloc extends Bloc<VisitingScreenEvent, VisitingScreenState> {
  final placeInteractor = PlaceInteractor(
    repository: PlaceRepository(apiPlaces: ApiPlaces()),
  );

  VisitingScreenBloc() : super(VisitingScreenIsEmpty()) {
    on<VisitingScreenLoad>(
      (event, emit) async {
        emit(
           VisitingScreenLoaded(
            favoritePlaces: placeInteractor.getFavoritesPlaces(),
            visitedPlaces: placeInteractor.getVisitPlaces(),
          ),
        );
      },
    );
  }
}