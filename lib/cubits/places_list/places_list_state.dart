part of 'places_list_cubit.dart';

abstract class PlacesListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PlacesListEmptyState extends PlacesListState {}

class PlacesListLoadedState extends PlacesListState {
  final List<Place> places;

  @override
  List<Object?> get props => [places];

  PlacesListLoadedState({
    required this.places,
  });
}
