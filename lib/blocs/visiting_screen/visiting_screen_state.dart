import 'package:equatable/equatable.dart';

import 'package:places/data/model/place.dart';

abstract class VisitingScreenState extends Equatable {
  @override
  List<Object?> get props => [];

  const VisitingScreenState();
}

// Состояние пустого экрана
class VisitingScreenEmpty extends VisitingScreenState {}

// Состояние добавленных мест
class VisitingScreenIsNotEmpty extends VisitingScreenState {
  final Set<Place> places;

  @override
  List<Object?> get props => [places];

  const VisitingScreenIsNotEmpty({
    required this.places,
  });

  @override
  String toString() {
    return 'VisitingScreenIsNotEmpty {places: $places}';
  }
}
