part of 'search_history_bloc.dart';

abstract class SearchHistoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

// Пустое состояние истории поиска
class SearchHistoryEmptyState extends SearchHistoryState {}

// Состояние истории поиска с данными
class SearchHistoryHasValueAction extends SearchHistoryState {
  final Set<String> searchStoryList;
  final bool showHistoryList;

  @override
  List<Object?> get props => [searchStoryList];

  SearchHistoryHasValueAction({
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

// Состояние удаления всех элементов истории поиска
class RemoveAllItemsFromHistoryAction extends SearchHistoryState {
  final Set<String> historyList;

  @override
  List<Object?> get props => [historyList];

  RemoveAllItemsFromHistoryAction({required this.historyList});
}
