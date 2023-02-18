part of 'visited_screen_bloc.dart';

abstract class VisitedScreenEvent extends Equatable {
  @override
  List<Object?> get props => [];

  const VisitedScreenEvent();
}

// Пустой список мест
class VisitedListIsEmpty extends VisitedScreenEvent {}

class AddToVisitedEvent extends VisitedScreenEvent {
  final bool isFavorite;
  final int placeIndex;
  final Place place;

  const AddToVisitedEvent({
    required this.isFavorite,
    required this.placeIndex,
    required this.place,
  });
}

class RemoveFromVisitedEvent extends VisitedScreenEvent {
  final bool isFavorite;
  final int placeIndex;
  final Place place;

  const RemoveFromVisitedEvent({
    required this.isFavorite,
    required this.placeIndex,
    required this.place,
  });
}

class DragCardOnVisitedEvent extends VisitedScreenEvent {
  final List<Place> places;
  final int oldIndex;
  final int newIndex;

  const DragCardOnVisitedEvent({
    required this.places,
    required this.oldIndex,
    required this.newIndex,
  });
}
