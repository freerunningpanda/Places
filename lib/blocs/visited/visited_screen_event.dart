part of 'visited_screen_bloc.dart';

abstract class VisitedScreenEvent {
  const VisitedScreenEvent();
}

// Список посещённых мест
class VisitedListLoadedEvent extends VisitedScreenEvent {}

class AddToVisitedEvent extends VisitedScreenEvent {
  final bool isFavorite;
  final DbPlace place;
  final AppDb db;

  const AddToVisitedEvent({
    required this.isFavorite,
    required this.place,
    required this.db,
  });
}

class DragCardOnVisitedEvent extends VisitedScreenEvent {
  final List<DbPlace> places;
  final int oldIndex;
  final int newIndex;
  final AppDb db;

  const DragCardOnVisitedEvent({
    required this.places,
    required this.oldIndex,
    required this.newIndex,
    required this.db,
  });
}
