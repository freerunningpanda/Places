import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:places/data/api/api_places.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/mocks.dart';

part 'search_screen_event.dart';
part 'search_screen_state.dart';

class SearchScreenBloc extends Bloc<SearchScreenEvent, SearchScreenState> {
  List<Place> filteredPlaces = PlaceInteractor.filtersWithDistance.toList();

  bool hasFocus = false;
  PlaceInteractor interactor = PlaceInteractor(
    repository: PlaceRepository(
      apiPlaces: ApiPlaces(),
    ),
  );

  SearchScreenBloc() : super(SearchScreenEmptyState()) {
    activeFocus(isActive: true);
    searchPlaces(interactor.query, interactor.controller);
    on<PlacesFoundEvent>((event, emit) {
      debugPrint('Длина списка мест после поиска: ${PlaceInteractor.filteredPlaces.length}');
      emit(
        SearchScreenPlacesFoundState(
          filteredPlaces: filteredPlaces,
          length: PlaceInteractor.filtersWithDistance.length,
        ),
      );

      if (filteredPlaces.isEmpty) {
        emit(SearchScreenEmptyState());
      }
      if (event.isHistoryClear) {
        emit(
          SearchScreenPlacesFoundState(
            filteredPlaces: event.isHistoryClear ? PlaceInteractor.filtersWithDistance.toList() : filteredPlaces,
            length: PlaceInteractor.filtersWithDistance.length,
          ),
        );
      }
    });
  }

  void activeFocus({required bool isActive}) {
    // ignore: prefer-conditional-expressions
    if (isActive) {
      interactor.hasFocus = true;
    } else {
      interactor.hasFocus = false;
    }
  }

  void searchPlaces(String query, TextEditingController controller) {
    if (PlaceInteractor.activeFilters.isEmpty) {
      for (final el in PlaceInteractor.filtersWithDistance) {
        final distance = Geolocator.distanceBetween(
          Mocks.mockLat,
          Mocks.mockLot,
          el.lat,
          el.lng,
        );
        if (distance >= Mocks.rangeValues.start && distance <= Mocks.rangeValues.end) {
          filteredPlaces = PlaceInteractor.filtersWithDistance.where((sight) {
            final sightTitle = sight.name.toLowerCase();
            final input = query.toLowerCase();
            debugPrint('filteredPlaces: $filteredPlaces');

            return sightTitle.contains(input);
          }).toList();
        }
      }
    } else if (PlaceInteractor.activeFilters.isNotEmpty) {
      for (final el in PlaceInteractor.initialFilteredPlaces) {
        final distance = Geolocator.distanceBetween(
          Mocks.mockLat,
          Mocks.mockLot,
          el.lat,
          el.lng,
        );
        if (distance >= Mocks.rangeValues.start && distance <= Mocks.rangeValues.end) {
          filteredPlaces = PlaceInteractor.filtersWithDistance.where((sight) {
            final sightTitle = sight.name.toLowerCase();
            final input = query.toLowerCase();

            return sightTitle.contains(input);
          }).toList();
        }
      }
    }

    if (controller.text.isEmpty) {
      PlaceInteractor.filteredPlaces.clear();
    }
  }
}
