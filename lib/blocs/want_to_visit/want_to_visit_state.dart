part of 'want_to_visit_bloc.dart';

abstract class WantToVisitScreenState extends Equatable {
  @override
  List<Object?> get props => [];

  const WantToVisitScreenState();
}

// Состояние пустого экрана
class WantToVisitScreenEmptyState extends WantToVisitScreenState {}

// Состояние добавленных мест
class WantToVisitScreenIsNotEmpty extends WantToVisitScreenState {
  final List<DbPlace> favoritePlaces;
  final int length;

  @override
  List<Object?> get props => [
        favoritePlaces,
        length,
      ];

  const WantToVisitScreenIsNotEmpty({
    required this.favoritePlaces,
    required this.length,
  });

}

// Состояние списка после переноса места
class WantToVisitAfterDragState extends WantToVisitScreenState {
  final int oldIndex;
  final int newIndex;
  final List<DbPlace> favoritePlaces;

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
