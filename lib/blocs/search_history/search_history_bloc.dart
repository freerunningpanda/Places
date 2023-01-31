import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place.dart';

part 'search_history_event.dart';
part 'search_history_state.dart';

class SearchHistoryBloc extends Bloc<SearchHistoryEvent, SearchHistoryState> {
  final searchStoryList = PlaceInteractor.searchHistoryList;
  bool hasFocus = false;

  SearchHistoryBloc() : super(SearchHistoryEmptyState()) {
    activeFocus(isActive: true);
    on<AddItemToHistoryEvent>(
      (event, emit) => emit(
        SearchHistoryHasValueState(searchStoryList: searchStoryList, showHistoryList: true),
      ),
    );
    // on<RemoveItemFromHistory>((event, emit) => emit(
    //   SearchHistoryHasValueState(searchStoryList: searchStoryList, showHistoryList: true),
    // ),);
    on<RemoveAllItemsFromHistory>(
      (event, emit) {
        searchStoryList.clear();
        emit(
          SearchHistoryEmptyState(),
        );
      },
    );
  }

  void activeFocus({required bool isActive}) {
    // ignore: prefer-conditional-expressions
    if (isActive) {
      hasFocus = true;
    } else {
      hasFocus = false;
    }
  }
}
