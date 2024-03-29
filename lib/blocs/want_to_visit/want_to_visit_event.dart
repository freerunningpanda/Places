part of 'want_to_visit_bloc.dart';

abstract class VisitingScreenEvent {
  const VisitingScreenEvent();
}

// Список мест
class FavoriteListLoadedEvent extends VisitingScreenEvent {}

class AddToWantToVisitEvent extends VisitingScreenEvent {
  final bool isFavorite;
  final DbPlace place;
  final AppDb db;

  const AddToWantToVisitEvent({
    required this.isFavorite,
    required this.place,
    required this.db,
  });
}

class RemoveFromWantToVisitEvent extends VisitingScreenEvent {
  final bool isFavorite;
  final DbPlace place;
  final AppDb db;

  const RemoveFromWantToVisitEvent({
    required this.isFavorite,
    required this.place,
    required this.db,
  });
}

class DragCardOnWantToVisitEvent extends VisitingScreenEvent {
  final List<DbPlace> places;
  final int oldIndex;
  final int newIndex;
  final AppDb db;

  const DragCardOnWantToVisitEvent({
    required this.places,
    required this.oldIndex,
    required this.newIndex,
    required this.db,
  });
}
