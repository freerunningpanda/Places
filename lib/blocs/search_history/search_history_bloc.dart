
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:places/data/api/api_places.dart';
import 'package:places/data/database/database.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/place_repository.dart';

part 'search_history_event.dart';
part 'search_history_state.dart';

class SearchHistoryBloc extends Bloc<SearchHistoryEvent, SearchHistoryState> {
  final searchHistoryList = PlaceInteractor.searchHistoryList;
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
            searchStoryList: event.list,
            hasFocus: event.hasFocus,
            isDeleted: event.isDeleted,
          ),
        );
      },
    );
    on<AddItemToHistoryEvent>(
      (event, emit) {
        saveSearchHistory(interactor.query, interactor.controller);
        emit(
          SearchHistoryHasValueState(
            searchStoryList: event.list,
            hasFocus: event.hasFocus,
            isDeleted: event.isDeleted,
            index: event.index,
          ),
        );
      },
    );
    on<RemoveItemFromHistory>(
      (event, emit) {
        removeItemFromHistory(event.index);
        emit(
          SearchHistoryHasValueState(
            searchStoryList: event.list,
            hasFocus: event.hasFocus,
            isDeleted: event.isDeleted,
            index: event.index,
          ),
        );
      },
    );
    on<RemoveAllItemsFromHistory>(
      (event, emit) {
        searchHistoryList.clear();
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

  void removeItemFromHistory(String index) {
    PlaceInteractor.searchHistoryList.remove(index);
  }
}