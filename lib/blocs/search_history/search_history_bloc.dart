import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:places/data/database/database.dart';
import 'package:places/data/model/place.dart';

part 'search_history_event.dart';
part 'search_history_state.dart';

class SearchHistoryBloc extends Bloc<SearchHistoryEvent, SearchHistoryState> {
  final _db = AppDb();
  List<SearchHistory> list = [];

  SearchHistoryBloc() : super(SearchHistoryEmptyState()) {
    on<ShowHistoryEvent>(
      (event, emit) {
        emit(
          SearchHistoryHasValueState(
            searchStoryList: list,
            hasFocus: event.hasFocus,
            isDeleted: event.isDeleted,
            length: list.length,
          ),
        );
      },
    );
    on<AddItemToHistoryEvent>(
      (event, emit) {
        emit(
          SearchHistoryHasValueState(
            searchStoryList: list,
            hasFocus: event.hasFocus,
            isDeleted: event.isDeleted,
            text: event.text,
            length: list.length,
          ),
        );
      },
    );
    on<RemoveItemFromHistory>(
      (event, emit) async {
        await removeItemFromHistory(event.id);
        final updatedList = list.where((element) => element.id != event.id).toList();
        emit(
          ItemRemovedFromHistoryState(
            searchStoryList: updatedList,
            hasFocus: event.hasFocus,
            isDeleted: event.isDeleted,
            length: updatedList.length,
          ),
        );
      },
    );
    on<RemoveAllItemsFromHistory>(
      (event, emit) {
        list.clear();
        emit(
          SearchHistoryEmptyState(),
        );
      },
    );
  }

  Future<void> removeItemFromHistory(int id) async {
    await _db.deleteHistory(id);

    // await loadHistorys();
  }

  Future<void> loadHistorys() async {
    list = await _db.allHistorysEntries;
    debugPrint('list: ${list.length}');
  }

  Future<void> addHistory(String text) async {
    await _db.addHistoryItem(
      SearchHistorysCompanion.insert(title: text),
    );
  }
}
