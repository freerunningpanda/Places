import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:places/data/database/database.dart';

part 'toggle_favorite_event.dart';
part 'toggle_favorite_state.dart';

class ToggleFavoriteCubit extends Cubit<IToggleFavoriteState> {
  ToggleFavoriteCubit() : super(ToggleFavoriteInitial());

  Future<void> toggleFavorite(DbPlace place, AppDb db) async {
    final isFavorite = await getValue(db, place);
    if (!isFavorite) {
      place.isFavorite = true;
      await db.addPlace(place, isSearchScreen: false);
    } else {
      place.isFavorite = false;
      await db.deletePlace(place);
    }

    emit(
      ToggleFavoriteState(
        db: db,
        place: place,
        isFavorite: isFavorite,
      ),
    );
  }

  // Получить значение свойства isFavorite
  Future<bool> getValue(AppDb db, DbPlace place) async {
    final list = await db.favoritePlacesEntries;
    final isFavorite = list.any((p) => p.id == place.id);

    return isFavorite;
  }
}
