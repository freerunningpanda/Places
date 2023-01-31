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
    on<ShowHistoryEvent>(
      (event, emit) {
        saveSearchHistory(interactor.query, interactor.controller);
        emit(
          SearchHistoryHasValueState(
            searchStoryList: searchStoryList,
            hasFocus: true,
          ),
        );
      },
    );
    on<AddItemToHistoryEvent>(
      (event, emit) {
        saveSearchHistory(interactor.query, interactor.controller);
        emit(
          SearchHistoryHasValueState(
            searchStoryList: searchStoryList,
            hasFocus: false,
          ),
        );
      },
    );
    on<RemoveAllItemsFromHistory>(
      (event, emit) {
        searchStoryList.clear();
        emit(
          SearchHistoryEmptyState(),
        );
      },
    );
  }

  void saveSearchHistory(String value, TextEditingController controller) {
    if (controller.text.isEmpty) return;
    PlaceInteractor.searchHistoryList.add(value);
  }
}
