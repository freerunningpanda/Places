import 'package:places/redux/state/search_screen_state.dart';

class AppState {
  final SearchScreenState searchScreenState;

  AppState({
    required this.searchScreenState,
  });

  AppState cloneWith({
    required SearchScreenState searchScreenState,
  }) =>
      AppState(
        searchScreenState: searchScreenState,
      );
}
