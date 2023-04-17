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
  final List<DbPlace> visitedPlaces;
  final int length;

  @override
  List<Object?> get props => [
        visitedPlaces,
        length,
      ];

  const VisitedIsNotEmpty({
    required this.visitedPlaces,
    required this.length,
  });

}
