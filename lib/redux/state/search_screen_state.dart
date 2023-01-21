import 'package:equatable/equatable.dart';

import 'package:places/data/model/place.dart';

class SearchScreenState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchScreenEmptyState extends SearchScreenState {}

class SeacrhScreenFindedPlacesState extends SearchScreenState {
  final Set<Place> places;

  @override
  List<Object?> get props => [places];

  SeacrhScreenFindedPlacesState({
    required this.places,
  });
}
