part of 'search_screen_bloc.dart';

abstract class SearchScreenEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PlacesEmptyEvent extends SearchScreenEvent {}

class PlacesFoundEvent extends SearchScreenEvent {}
