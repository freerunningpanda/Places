part of 'search_history_bloc.dart';

abstract class SearchHistoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

// Пустое состояние истории поиска
class SearchHistoryEmptyState extends SearchHistoryState {}

// Состояние истории поиска с данными
class SearchHistoryHasValueState extends SearchHistoryState {
  final Set<String> searchStoryList;
  final bool showHistoryList;

  @override
  List<Object?> get props => [searchStoryList];

  SearchHistoryHasValueState({
    required this.searchStoryList,
    required this.showHistoryList,
  });
}

// Состояние пустого экрана найденных мест
class EmptyPlacesAction extends SearchHistoryState {}

// Состояние экрана в котором найдены места
class FoundedPlacesAction extends SearchHistoryState {
  final List<Place> filteredPlaces;

  @override
  List<Object?> get props => [filteredPlaces];

  FoundedPlacesAction({
    required this.filteredPlaces,
  });
}
