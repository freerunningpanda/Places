import 'package:places/redux/state/search_bar_state.dart';
import 'package:places/redux/state/search_screen_state.dart';

class AppState {
  // final SearchBarState searchBarState;
  final SearchScreenState searchScreenState;

  AppState({
    // required this.searchBarState,
    required this.searchScreenState,
  });

  AppState cloneWith({
    // required SearchBarState searchBarState,
    required SearchScreenState searchScreenState,
  }) =>
      AppState(
        // searchBarState: searchBarState,
        searchScreenState: searchScreenState,
      );
}
