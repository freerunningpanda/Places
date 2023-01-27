part of 'search_screen_bloc.dart';

abstract class SearchScreenState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchScreenEmptyState extends SearchScreenState {}

class SearchScreenPlacesFoundState extends SearchScreenState {
  final List<Place> filteredPlaces;

  @override
  List<Object?> get props => [filteredPlaces];

  SearchScreenPlacesFoundState({
    required this.filteredPlaces,
  });
}
