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
}
