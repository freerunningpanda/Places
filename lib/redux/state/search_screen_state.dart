import 'package:equatable/equatable.dart';

import 'package:places/data/model/place.dart';
import 'package:places/redux/action/action.dart';
import 'package:places/redux/action/search_action.dart';

abstract class SearchScreenState extends Equatable {
  @override
  List<Object?> get props => [];
}

// Состояние пустого экрана найденных мест
class SearchScreenEmptyState extends SearchScreenState {
  final PlacesEmptyAction action;

  SearchScreenEmptyState({
    required this.action,
  });
}

// Состояние экрана в котором найдены места
class SearchScreenFoundPlacesState extends SearchScreenState {
  final List<Place> filteredPlaces;

  @override
  List<Object?> get props => [filteredPlaces];

  SearchScreenFoundPlacesState({
    required this.filteredPlaces,
  });
}

// Пустое состояние истории поиска
class SearchHistoryEmptyState extends SearchScreenState {
  final SearchHistoryEmptyAction action;

  SearchHistoryEmptyState({
    required this.action,
  });
}

// Состояние истории поиска с данными
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

// Состояние удаления всех элементов истории поиска
class RemoveAllItemsFromHistoryState extends SearchScreenState {
  final Set<String> historyList;

  @override
  List<Object?> get props => [historyList];

  RemoveAllItemsFromHistoryState({required this.historyList});
}