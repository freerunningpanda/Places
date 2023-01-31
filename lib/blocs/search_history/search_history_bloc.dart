import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:places/data/api/api_places.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/place_repository.dart';

part 'search_history_event.dart';
part 'search_history_state.dart';

class SearchHistoryBloc extends Bloc<SearchHistoryEvent, SearchHistoryState> {
  final searchStoryList = PlaceInteractor.searchHistoryList;
  PlaceInteractor interactor = PlaceInteractor(
    repository: PlaceRepository(
      apiPlaces: ApiPlaces(),
    ),
  );

  SearchHistoryBloc() : super(SearchHistoryEmptyState()) {
    on<AddItemToHistoryEvent>(
      (event, emit) {
        activeFocus(isActive: false);
        saveSearchHistory(interactor.query, interactor.controller);
        emit(
          SearchHistoryHasValueState(searchStoryList: searchStoryList, showHistoryList: true),
        );
      },
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
      interactor.hasFocus = true;
    } else {
      interactor.hasFocus = false;
    }
  }

  void saveSearchHistory(String value, TextEditingController controller) {
    if (controller.text.isEmpty) return;
    PlaceInteractor.searchHistoryList.add(value);
  }
}
