import 'package:equatable/equatable.dart';

import 'package:places/data/model/place.dart';

abstract class VisitingScreenState extends Equatable {
  @override
  List<Object?> get props => [];

  const VisitingScreenState();
}

// Состояние пустого экрана
class VisitingScreenIsEmpty extends VisitingScreenState {}

// Состояние добавленных мест
class VisitingScreenLoaded extends VisitingScreenState {
  final Set<Place> favoritePlaces;
  final Set<Place> visitedPlaces;

  @override
  List<Object?> get props => [favoritePlaces, visitedPlaces];

  const VisitingScreenLoaded({
    required this.favoritePlaces,
    required this.visitedPlaces,
  });

  @override
  String toString() {
    return 'VisitingScreenIsNotEmpty {places: $favoritePlaces}';
  }
}
