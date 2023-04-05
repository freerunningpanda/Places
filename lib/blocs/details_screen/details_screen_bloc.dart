import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/api/api_places.dart';
import 'package:places/data/database/database.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/repository/place_repository.dart';

part 'details_screen_event.dart';
part 'details_screen_state.dart';

class DetailsScreenBloc extends Bloc<DetailsScreenEvent, DetailsScreenState> {
  final interactor = PlaceInteractor(repository: PlaceRepository(apiPlaces: ApiPlaces()));
  bool isLoaded = false;

  DetailsScreenBloc() : super(DetailsScreenLoadingState()) {
    on<DetailsScreenEvent>((event, emit) {
      getPlace(place: event.place);
      isLoaded = true;
      emit(DetailsScreenLoadedState(place: event.place));
      if (!isLoaded) {
        emit(DetailsScreenLoadingState());
      }
    });
  }

  Future<void> getPlace({required DbPlace place}) async {
    await interactor.getPlaceDetails(place);
  }
}
