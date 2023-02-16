part of 'visiting_screen_bloc.dart';

abstract class VisitingScreenEvent extends Equatable {
  @override
  List<Object?> get props => [];

  const VisitingScreenEvent();
}

// Пустой список мест
class FavoriteListIsEmpty extends VisitingScreenEvent {}

class AddToWantToVisitEvent extends VisitingScreenEvent {
  final bool isFavorite;
  final int placeIndex;
  final Place place;

  const AddToWantToVisitEvent({
    required this.isFavorite,
    required this.placeIndex,
    required this.place,
  });
}

class RemoveFromWantToVisitEvent extends VisitingScreenEvent {
  final bool isFavorite;
  final int placeIndex;
  final Place place;

  const RemoveFromWantToVisitEvent({
    required this.isFavorite,
    required this.placeIndex,
    required this.place,
  });
}

class DragCardOnWantToVisitEvent extends VisitingScreenEvent {
  final List<Place> place;
  final int oldIndex;
  final int newIndex;

  const DragCardOnWantToVisitEvent({
    required this.place,
    required this.oldIndex,
    required this.newIndex,
  });
}
