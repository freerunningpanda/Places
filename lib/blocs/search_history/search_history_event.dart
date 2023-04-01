part of 'search_history_bloc.dart';

abstract class SearchHistoryEvent {}

class ShowHistoryEvent extends SearchHistoryEvent {
  final bool isDeleted; // Сменится на false. Мы должны показать историю с элементами для отображения. Не удаления.
  final bool hasFocus; // Будет true. При наличии фокуса увидим список истории поиска.
  final List<SearchHistory> list;

  ShowHistoryEvent({
    required this.isDeleted,
    required this.hasFocus,
    required this.list,
  });
}

class AddItemToHistoryEvent extends SearchHistoryEvent {
  final String index; // Для добавления индекса (значения text из текстового контроллера)
  final bool isDeleted; // При добавлении будет true.
  final bool hasFocus; // Список истории будет пропадать при добавлении нового места в него. Включится false.
  final List<SearchHistory> list;

  AddItemToHistoryEvent({
    required this.index,
    required this.isDeleted,
    required this.hasFocus,
    required this.list,
  });
}

class RemoveItemFromHistory extends SearchHistoryEvent {
  final String index; // Для добавления индекса (значения text из текстового контроллера)
  final bool isDeleted; // При удалении будет true. Виджет перерисуется.
  final bool hasFocus; // Останется на true, чтобы после удаления элемента мы оставались на виджете поисковой истории.
  final List<SearchHistory> list;

  RemoveItemFromHistory({
    required this.index,
    required this.isDeleted,
    required this.hasFocus,
    required this.list,
  });
}

class RemoveAllItemsFromHistory extends SearchHistoryEvent {}
