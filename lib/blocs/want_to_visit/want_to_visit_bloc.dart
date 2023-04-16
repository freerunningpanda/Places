import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/api/api_places.dart';
import 'package:places/data/database/database.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/repository/place_repository.dart';

part 'want_to_visit_event.dart';
part 'want_to_visit_state.dart';

class WantToVisitBloc extends Bloc<VisitingScreenEvent, WantToVisitScreenState> {
  final AppDb db;
  final interactor = PlaceInteractor(
    repository: PlaceRepository(
      apiPlaces: ApiPlaces(),
    ),
  );

  WantToVisitBloc({required this.db}) : super(WantToVisitScreenEmptyState()) {
    on<FavoriteListLoadedEvent>((event, emit) async {
      /// Список избранных мест из бд
      final loadedPlaces = await getPlaces(db);
      if (loadedPlaces.isEmpty) {
        emit(
          WantToVisitScreenEmptyState(),
        );
      } else {
        emit(
          WantToVisitScreenIsNotEmpty(
            favoritePlaces: loadedPlaces,
            length: loadedPlaces.length,
          ),
        );
      }
    });
    on<AddToWantToVisitEvent>(
      (event, emit) async {
        final dbFavoritePlaces = await event.db.favoritePlacesEntries;
        emit(
          WantToVisitScreenIsNotEmpty(
            favoritePlaces: dbFavoritePlaces,
            length: dbFavoritePlaces.length,
          ),
        );
      },
    );
    on<RemoveFromWantToVisitEvent>((event, emit) async {
      await interactor.removeFromFavorites(place: event.place, db: event.db);
      final dbFavoritePlaces = await event.db.favoritePlacesEntries;
      emit(
        WantToVisitScreenIsNotEmpty(
          favoritePlaces: dbFavoritePlaces,
          length: dbFavoritePlaces.length,
        ),
      );
    });

  }

  Future<void> dragCard(List<DbPlace> places, AppDb db, int oldIndex, int newIndex) async {
    var modifiedIndex = newIndex;
    if (newIndex > oldIndex) modifiedIndex--;

    final place = places.removeAt(oldIndex);

    places.insert(modifiedIndex, place);
    for (var i = 0; i < places.length; i++) {
      final updatedPlace = places[i].copyWith(index: Value<int>(i));
      await db.updatePlace(updatedPlace);
    }

    
  }
  Future<List<DbPlace>> getPlaces(AppDb db) async {
    final list = await db.favoritePlacesEntries;

    return list;
  }
}
