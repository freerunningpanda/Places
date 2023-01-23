import 'package:equatable/equatable.dart';

import 'package:places/data/model/place.dart';
import 'package:places/redux/action/action.dart';
import 'package:places/redux/action/search_action.dart';

abstract class SearchScreenState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchScreenEmptyState extends SearchScreenState {
  final PlacesEmptyAction action;

  SearchScreenEmptyState({
    required this.action,
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

class SearchHistoryEmptyState extends SearchScreenState {
  final SearchHistoryEmptyAction action;

  SearchHistoryEmptyState({
    required this.action,
  });
}

class SearchHistoryHasValueState extends SearchScreenState {
  final Set<String> searchStoryList;
  final bool showHistoryList;

  @override
  List<Object?> get props => [searchStoryList];

  SearchHistoryHasValueState({
    required this.searchStoryList,
    required this.showHistoryList,
  });
}
