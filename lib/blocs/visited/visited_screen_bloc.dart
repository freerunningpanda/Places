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
            isVisited: true,
            length: visitedPlaces.length,
          ),
        );
      }
    });
    on<AddToVisitedEvent>(
      (event, emit) async {
        final dbVisitedPlaces = await event.db.visitedPlacesEntries;
        emit(
          VisitedIsNotEmpty(
            visitedPlaces: dbVisitedPlaces,
            isVisited: event.isVisited,
            length: dbVisitedPlaces.length,
          ),
        );
      },
    );
  }

  Future<List<DbPlace>> getVisitedPlaces(AppDb db) async {
    final list = await db.visitedPlacesEntries;

    return list;
  }
}
