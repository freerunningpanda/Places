import 'package:places/redux/action/action.dart';
import 'package:places/redux/state/appstate.dart';
import 'package:places/redux/state/search_screen_state.dart';
import 'package:redux/redux.dart';

final reducer = combineReducers<AppState>([
  TypedReducer<AppState, PlacesFoundAction>(_placesFound),
  TypedReducer<AppState, PlacesEmptyAction>(_placesEmpty),
]);

AppState _placesFound(AppState state, PlacesFoundAction action) {
  return state.cloneWith(searchScreenState: SearchScreenFoundPlacesState(filteredPlaces: action.filteredPlaces));
}

AppState _placesEmpty(AppState state, PlacesEmptyAction action) {
  return state.cloneWith(searchScreenState: SearchScreenEmptyState(action: action));
}
