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
  final bool hasFocus;

  @override
  List<Object?> get props => [searchStoryList, hasFocus];

  SearchHistoryHasValueState({
    required this.searchStoryList,
    required this.hasFocus,
  });

  @override
  String toString() {
    return 'hasFocus: $hasFocus';
  }

  SearchHistoryHasValueState copyWith({
    Set<String>? searchStoryList,
    bool? hasFocus,
  }) {
    return SearchHistoryHasValueState(
      searchStoryList: searchStoryList ?? this.searchStoryList,
      hasFocus: hasFocus ?? this.hasFocus,
    );
  }
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
