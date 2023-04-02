import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
          ),
        );
      },
    );
    on<RemoveItemFromHistory>(
      (event, emit) {
        removeItemFromHistory(event.text);
        emit(
          SearchHistoryHasValueState(
            searchStoryList: list,
            hasFocus: event.hasFocus,
            isDeleted: event.isDeleted,
            text: event.text,
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

  Future<void> removeItemFromHistory(String text) async {
    await _db.deleteHistory(text);

    await loadHistorys();
  }

  Future<void> loadHistorys() async {
    list = await _db.allHistorysEntries;
  }

  Future<void> addHistory(String text) async {
    await _db.addHistoryItem(
      SearchHistorysCompanion.insert(title: text),
    );
  }
}
