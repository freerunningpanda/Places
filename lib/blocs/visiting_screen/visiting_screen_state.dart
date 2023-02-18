part of 'visiting_screen_bloc.dart';

abstract class WantToVisitScreenState extends Equatable {
  @override
  List<Object?> get props => [];

  const WantToVisitScreenState();
}

// Состояние пустого экрана
class WantToVisitScreenEmptyState extends WantToVisitScreenState {}

// Состояние добавленных мест
class WantToVisitScreenIsNotEmpty extends WantToVisitScreenState {
  final int placeIndex;
  final Set<Place> favoritePlaces;
  final int length;

  @override
  List<Object?> get props => [
        placeIndex,
        favoritePlaces,
        length,
      ];

  const WantToVisitScreenIsNotEmpty({
    required this.placeIndex,
    required this.favoritePlaces,
    required this.length,
  });

  @override
  String toString() {
    return 'VisitingScreenIsNotEmpty {places: $placeIndex}';
  }
}

// Состояние списка после переноса места
class WantToVisitAfterDragState extends WantToVisitScreenState {
  final int oldIndex;
  final int newIndex;
  final List<Place> favoritePlaces;

  @override
  List<Object?> get props => [
        oldIndex,
        newIndex,
        favoritePlaces,
      ];

  const WantToVisitAfterDragState({
    required this.oldIndex,
    required this.newIndex,
    required this.favoritePlaces,
  });

  @override
  String toString() {
    return 'newIndex $newIndex}';
  }
}
