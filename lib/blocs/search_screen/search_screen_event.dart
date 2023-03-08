part of 'search_screen_bloc.dart';

abstract class SearchScreenEvent {}

class PlacesEmptyEvent extends SearchScreenEvent {}

class PlacesFoundEvent extends SearchScreenEvent {
  final bool isHistoryClear;
  // final List<Place> places;

  PlacesFoundEvent({required this.isHistoryClear});
}
