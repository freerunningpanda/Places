import 'package:places/redux/state/search_screen_state.dart';

class AppState {
  final SearchScreenStateRedux searchScreenState;

  AppState({
    required this.searchScreenState,
  });

  AppState cloneWith({
    required SearchScreenStateRedux searchScreenState,
  }) =>
      AppState(
        searchScreenState: searchScreenState,
      );
}
