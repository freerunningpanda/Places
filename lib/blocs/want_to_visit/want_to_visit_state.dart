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

