part of 'search_history_bloc.dart';

abstract class SearchHistoryEvent {}

class ShowHistoryEvent extends SearchHistoryEvent {}

class AddItemToHistoryEvent extends SearchHistoryEvent {}

class RemoveItemFromHistory extends SearchHistoryEvent {}

class RemoveAllItemsFromHistory extends SearchHistoryEvent {}

