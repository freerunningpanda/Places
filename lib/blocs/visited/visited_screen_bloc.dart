import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/database/database.dart';

part 'visited_screen_event.dart';
part 'visited_screen_state.dart';

class VisitedScreenBloc extends Bloc<VisitedScreenEvent, VisitedScreenState> {
  final AppDb db;

  VisitedScreenBloc({required this.db}) : super(VisitedEmptyState()) {
    on<VisitedListLoadedEvent>((event, emit) async {
      /// Список посещённых мест из бд
      final visitedPlaces = await getVisitedPlaces(db);
      if (visitedPlaces.isEmpty) {
        emit(VisitedEmptyState());
      } else {
        emit(
          VisitedIsNotEmpty(
            visitedPlaces: visitedPlaces,
            length: visitedPlaces.length,
          ),
        );
      }
    });
    on<AddToVisitedEvent>(
      (event, emit) async {
        final dbVisitedPlaces = await event.db.favoritePlacesEntries;
        emit(
          VisitedIsNotEmpty(
            visitedPlaces: dbVisitedPlaces,
            length: dbVisitedPlaces.length,
          ),
        );
      },
    );
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

  Future<List<DbPlace>> getVisitedPlaces(AppDb db) async {
    final list = await db.favoritePlacesEntries; // TODO: Заменить на посещённые места

    return list;
  }
}
