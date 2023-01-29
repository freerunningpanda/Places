part of 'search_history_bloc.dart';

abstract class SearchHistoryEvent {}

class AddItemToHistoryEvent extends SearchHistoryEvent {}

class RemoveItemFromHistory extends SearchHistoryEvent {}

