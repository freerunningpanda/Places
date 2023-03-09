part of 'search_screen_bloc.dart';

abstract class SearchScreenState extends Equatable {
  @override
  List<Object?> get props => [];

  const SearchScreenState();
}

class SearchScreenEmptyState extends SearchScreenState {}

class SearchScreenPlacesFoundState extends SearchScreenState {
  final List<Place> filteredPlaces;
  final int length;

  @override
  List<Object?> get props => [filteredPlaces, length];

  const SearchScreenPlacesFoundState({
    required this.filteredPlaces,
    required this.length,
  });
}
