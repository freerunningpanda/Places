import 'package:equatable/equatable.dart';
import 'package:places/data/model/place.dart';

abstract class SearchAction extends Equatable {
  @override
  List<Object?> get props => [];
}

// Пустое действие истории поиска
class SearchHistoryEmptyAction extends SearchAction {}

// Действие истории поиска с данными
class SearchHistoryHasValueAction extends SearchAction {
  final Set<String> searchStoryList;
  final bool showHistoryList;

  @override
  List<Object?> get props => [searchStoryList];

  SearchHistoryHasValueAction({
    required this.searchStoryList,
    required this.showHistoryList,
  });
}

// Действие пустого экрана найденных мест
class EmptyPlacesAction extends SearchAction {}

// Действие экрана в котором найдены места
class FoundedPlacesAction extends SearchAction {
  final List<Place> filteredPlaces;

  @override
  List<Object?> get props => [filteredPlaces];

  FoundedPlacesAction({
    required this.filteredPlaces,
  });
}

// Действие удаления всех элементов истории поиска
class RemoveAllItemsFromHistoryAction extends SearchAction {
  final Set<String> historyList;

  @override
  List<Object?> get props => [historyList];

  RemoveAllItemsFromHistoryAction({required this.historyList});
}
