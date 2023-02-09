part of 'search_history_bloc.dart';

abstract class SearchHistoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ShowHistoryEvent extends SearchHistoryEvent {}

class AddItemToHistoryEvent extends SearchHistoryEvent {}

// Данное событие негде не используется, потому что Bloc не видит изменений
// при удалении элемента из набора, поэтому виджет не перестраивается
// Оставил данную реализацию на провайдере
class RemoveItemFromHistory extends SearchHistoryEvent {
  final String index;

  @override
  List<Object?> get props => [index];

  RemoveItemFromHistory({
    required this.index,
  });
}

class RemoveAllItemsFromHistory extends SearchHistoryEvent {}
