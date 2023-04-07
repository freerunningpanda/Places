part of 'visited_screen_bloc.dart';

abstract class VisitedScreenEvent {


  const VisitedScreenEvent();
}

// Пустой список мест
class VisitedListIsEmpty extends VisitedScreenEvent {}

class AddToVisitedEvent extends VisitedScreenEvent {
  final bool isFavorite;
  final int placeIndex;
  final DbPlace place;

  const AddToVisitedEvent({
    required this.isFavorite,
    required this.placeIndex,
    required this.place,
  });
}

class RemoveFromVisitedEvent extends VisitedScreenEvent {
  final bool isFavorite;
  final int placeIndex;
  final DbPlace place;

  const RemoveFromVisitedEvent({
    required this.isFavorite,
    required this.placeIndex,
    required this.place,
  });
}

class DragCardOnVisitedEvent extends VisitedScreenEvent {
  final List<DbPlace> places;
  final int oldIndex;
  final int newIndex;

  const DragCardOnVisitedEvent({
    required this.places,
    required this.oldIndex,
    required this.newIndex,
  });
}
