import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';


part 'search_bar_event.dart';
part 'search_bar_state.dart';

class SearchBarBloc extends Bloc<SearchBarEvent, SearchBarState> {

  SearchBarBloc() : super(SearchBarEmptyState()) {
    on<SearchBarEvent>(
      (event, emit) {
        debugPrint('Value from history: ${event.value}');
        emit(
          SearchBarHasValueState(value: event.value),
        );
      },
    );
  }
}
