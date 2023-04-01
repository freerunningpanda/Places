part of 'search_history_bloc.dart';

abstract class SearchHistoryState extends Equatable {
  @override
  List<Object?> get props => [];

  const SearchHistoryState();
}

// Пустое состояние истории поиска
class SearchHistoryEmptyState extends SearchHistoryState {}

// Состояние истории поиска с данными
class SearchHistoryHasValueState extends SearchHistoryState {
  final String?
      index; // Берётся значение text из контроллера. Нужен для обновления стейта после удаления элемента из списка.
  final List<SearchHistory> searchStoryList;
  final bool hasFocus;
  final bool isDeleted; // Нужен для обновления стейта после удаления элемента из списка.

  @override
  List<Object?> get props => [index, searchStoryList, hasFocus, isDeleted];

  const SearchHistoryHasValueState({
    this.index,
    required this.searchStoryList,
    required this.hasFocus,
    required this.isDeleted,
  });
}

// Состояние пустого экрана найденных мест
class EmptyPlacesAction extends SearchHistoryState {}

// Состояние экрана в котором найдены места
class FoundedPlacesAction extends SearchHistoryState {
  final List<Place> filteredPlaces;

  @override
  List<Object?> get props => [filteredPlaces];

  const FoundedPlacesAction({
    required this.filteredPlaces,
  });
}
