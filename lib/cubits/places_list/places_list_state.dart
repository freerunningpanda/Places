part of 'places_list_cubit.dart';

abstract class PlacesListState extends Equatable {
  @override
  List<Object?> get props => [];

  const PlacesListState();
}

class PlacesListEmptyState extends PlacesListState {}

class PlaceListLoadingState extends PlacesListState {}

// ignore: must_be_immutable
class PlacesListLoadedState extends PlacesListState {
  final List<DbPlace> places;
  bool? isAddPlaceBtnVisible;
  DbPlace? tappedPlacemark;

  @override
  List<Object?> get props => [places, isAddPlaceBtnVisible, tappedPlacemark];

  PlacesListLoadedState({
    required this.places,
    this.isAddPlaceBtnVisible,
    this.tappedPlacemark,
  });
}

class PlacesListErrorState extends PlacesListState {
  final String error;

  @override
  List<Object?> get props => [error];

  const PlacesListErrorState({
    required this.error,
  });
}
