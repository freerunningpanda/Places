part of 'search_history_bloc.dart';

abstract class SearchHistoryEvent {}

class ShowHistoryEvent extends SearchHistoryEvent {
  final bool isDeleted;

  ShowHistoryEvent({
    required this.isDeleted,
  });
}

class AddItemToHistoryEvent extends SearchHistoryEvent {
  final String index;
  final bool isDeleted;

  AddItemToHistoryEvent({
    required this.index,
    required this.isDeleted,
  });
}

// Данное событие негде не используется, потому что Bloc не видит изменений
// при удалении элемента из набора, поэтому виджет не перестраивается
// Оставил данную реализацию на провайдере
class RemoveItemFromHistory extends SearchHistoryEvent {
  final String index;
  final bool isDeleted;

  RemoveItemFromHistory({
    required this.index,
    required this.isDeleted,
  });
}

class RemoveAllItemsFromHistory extends SearchHistoryEvent {}
