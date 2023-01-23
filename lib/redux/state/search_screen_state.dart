import 'package:equatable/equatable.dart';

import 'package:places/data/model/place.dart';

abstract class SearchScreenState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchScreenEmptyState extends SearchScreenState {
  final List<Place> filteredPlaces;

  @override
  List<Object?> get props => [filteredPlaces];

  SearchScreenEmptyState({
    required this.filteredPlaces,
  });
}

class SearchScreenFoundPlacesState extends SearchScreenState {
  final List<Place> filteredPlaces;

  @override
  List<Object?> get props => [filteredPlaces];

  SearchScreenFoundPlacesState({
    required this.filteredPlaces,
  });
}
