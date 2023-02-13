import 'package:equatable/equatable.dart';
import 'package:places/data/model/place.dart';

abstract class VisitingScreenEvent extends Equatable {
  @override
  List<Object?> get props => [];

  const VisitingScreenEvent();
}

// Пустой список мест
class AddToWantToVisitEvent extends VisitingScreenEvent {
  final bool isFavorite;
  final int placeIndex;
  final Place place;
  final int length;

  const AddToWantToVisitEvent({
    required this.isFavorite,
    required this.placeIndex,
    required this.place,
    required this.length,
  });
}
