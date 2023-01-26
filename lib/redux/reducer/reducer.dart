import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/redux/action/action.dart';
import 'package:places/redux/action/search_action.dart';
import 'package:places/redux/state/appstate.dart';
import 'package:places/redux/state/search_screen_state.dart';
import 'package:redux/redux.dart';

final reducer = combineReducers<AppState>([
  TypedReducer<AppState, PlacesFoundAction>(_placesFound),
  TypedReducer<AppState, PlacesEmptyAction>(_placesEmpty),
  TypedReducer<AppState, SearchHistoryHasValueAction>(_historyHasValue),
  TypedReducer<AppState, SearchHistoryEmptyAction>(_historyEmpty),
  TypedReducer<AppState, RemoveAllItemsFromHistoryAction>(_clearAllHistory),
]);

AppState _placesFound(AppState state, PlacesFoundAction action) {
  return state.cloneWith(searchScreenState: SearchScreenFoundPlacesState(filteredPlaces: action.filteredPlaces));
}

AppState _placesEmpty(AppState state, PlacesEmptyAction action) {
  return state.cloneWith(searchScreenState: SearchScreenEmptyState(action: action));
}

AppState _historyHasValue(AppState state, SearchHistoryHasValueAction action) {
  return state.cloneWith(
    searchScreenState: SearchHistoryHasValueState(
      searchStoryList: action.searchStoryList,
      showHistoryList: action.showHistoryList,
    ),
  );
}

AppState _historyEmpty(AppState state, SearchHistoryEmptyAction action) {
  return state.cloneWith(
    searchScreenState: SearchHistoryEmptyState(action: action),
  );
}

AppState _clearAllHistory(AppState state, RemoveAllItemsFromHistoryAction action) {
  PlaceInteractor.searchHistoryList.clear();
  
  return state.cloneWith(
    searchScreenState: RemoveAllItemsFromHistoryState(historyList: action.historyList),
  );
}
