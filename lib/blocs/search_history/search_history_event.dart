part of 'search_history_bloc.dart';

abstract class SearchHistoryEvent {}

class ShowHistoryEvent extends SearchHistoryEvent {
  final bool isDeleted; // Сменится на false. Мы должны показать историю с элементами для отображения. Не удаления.
  final bool hasFocus; // Будет true. При наличии фокуса увидим список истории поиска.

  ShowHistoryEvent({
    required this.isDeleted,
    required this.hasFocus,
  });
}

class AddItemToHistoryEvent extends SearchHistoryEvent {
  final String text; // Значения text из текстового контроллера
  final bool isDeleted; // При добавлении будет true.
  final bool hasFocus; // Список истории будет пропадать при добавлении нового места в него. Включится false.

  AddItemToHistoryEvent({
    required this.text,
    required this.isDeleted,
    required this.hasFocus,
  });
}

class RemoveItemFromHistory extends SearchHistoryEvent {
  final List<SearchHistory> updatedList;
  final int id;
  final int length; // Значения text из текстового контроллера
  final bool isDeleted; // При удалении будет true. Виджет перерисуется.
  final bool hasFocus; // Останется на true, чтобы после удаления элемента мы оставались на виджете поисковой истории.

  RemoveItemFromHistory({
    required this.updatedList,
    required this.id,
    required this.length,
    required this.isDeleted,
    required this.hasFocus,
  });
}

class RemoveAllItemsFromHistory extends SearchHistoryEvent {}
