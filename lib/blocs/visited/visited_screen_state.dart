part of 'visited_screen_bloc.dart';

abstract class VisitedScreenState extends Equatable {
  @override
  List<Object?> get props => [];

  const VisitedScreenState();
}

// Состояние пустого экрана
class VisitedEmptyState extends VisitedScreenState {}

// Состояние добавленных мест
class VisitedIsNotEmpty extends VisitedScreenState {
  final int placeIndex;
  final List<DbPlace> visitedPlaces;
  final int length;

  @override
  List<Object?> get props => [
        placeIndex,
        visitedPlaces,
        length,
      ];

  const VisitedIsNotEmpty({
    required this.placeIndex,
    required this.visitedPlaces,
    required this.length,
  });

  @override
  String toString() {
    return 'VisitedIsNotEmpty {places: $placeIndex}';
  }
}

// Состояние списка после переноса места
class VisitedAfterDragState extends VisitedScreenState {
  final int oldIndex;
  final int newIndex;
  final List<DbPlace> favoritePlaces;

  @override
  List<Object?> get props => [
        oldIndex,
        newIndex,
        favoritePlaces,
      ];

  const VisitedAfterDragState({
    required this.oldIndex,
    required this.newIndex,
    required this.favoritePlaces,
  });

  @override
  String toString() {
    return 'newIndex $newIndex}';
  }
}
