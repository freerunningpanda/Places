import 'package:flutter/material.dart';
import 'package:places/redux/action/action.dart';
import 'package:places/redux/state/appstate.dart';
import 'package:places/redux/state/search_bar_state.dart';
import 'package:places/redux/state/search_screen_state.dart';
import 'package:redux/redux.dart';

// SearchBarHasValueState reducer(SearchBarHasValueState state, dynamic action) =>
//     SearchBarHasValueState(value: _textReducer(state.value, action));

// Reducer<String> _textReducer = combineReducers<String>([
//   TypedReducer<String, SetQueryAction>(_setQueryAction),
// ]);

// String _setQueryAction(String value, SetQueryAction action) => action.value;

final reducer = combineReducers<AppState>([
  TypedReducer<AppState, PlacesFoundAction>(_placesFound),
  TypedReducer<AppState, PlacesEmptyAction>(_placesEmpty),
]);

AppState _placesFound(AppState state, PlacesFoundAction action) {
  return state.cloneWith(searchScreenState: SearchScreenFoundPlacesState(filteredPlaces: action.filteredPlaces));
}

AppState _placesEmpty(AppState state, PlacesEmptyAction action) {
  return state.cloneWith(searchScreenState: SearchScreenEmptyState(filteredPlaces: []));
}