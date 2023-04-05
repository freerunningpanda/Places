part of 'search_screen_bloc.dart';

abstract class SearchScreenEvent {}

class PlacesEmptyEvent extends SearchScreenEvent {}

class PlacesFoundEvent extends SearchScreenEvent {
  final bool isHistoryClear;
  final bool fromFiltersScreen;
  final bool isQueryEmpty;
  final bool searchHistoryIsEmpty;
  final List<DbPlace>? filteredPlaces;

  PlacesFoundEvent({
    this.filteredPlaces,
    required this.isHistoryClear,
    required this.isQueryEmpty,
    required this.fromFiltersScreen,
    required this.searchHistoryIsEmpty,
  });
}
