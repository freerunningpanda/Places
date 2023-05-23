import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/database/database.dart';
import 'package:places/data/interactor/place_interactor.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final DbPlace place;
  final PlaceInteractor _interactor;

  FavoriteCubit(this._interactor, {required this.place})
      : super(
          FavoriteState(isFavorite: place.isFavorite),
        );

  Future<void> toggleFavorite(DbPlace place, AppDb db) async {
    final isFavorite = await getValue(db, place);
    if (!isFavorite) {
      place.isFavorite = true;
      await _interactor.addToFavorites(place: place, db: db, isVisited: false);
    } else {
      place.isFavorite = false;
      await _interactor.removeFromFavorites(place: place, db: db);
    }
    emit(state.copyWith(isFavorite: place.isFavorite));
  }


    Future<bool> getValue(AppDb db, DbPlace place) async {
    final list = await db.favoritePlacesEntries;
    final isFavorite = list.any((p) => p.id == place.id);

    return isFavorite;
  }
}
