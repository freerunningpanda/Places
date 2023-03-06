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
  Set<Place> filteredPlaces = PlaceInteractor.filtersWithDistance;

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
      debugPrint('Длина списка мест после поиска: ${PlaceInteractor.filtersWithDistance.toList().length}');
      emit(
        SearchScreenPlacesFoundState(
          filteredPlaces: PlaceInteractor.filtersWithDistance.toList(),
          length: PlaceInteractor.filtersWithDistance.length,
        ),
      );

      if (PlaceInteractor.filtersWithDistance.isEmpty) {
        emit(SearchScreenEmptyState());
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
          PlaceInteractor.filtersWithDistance = PlaceInteractor.filtersWithDistance.where((sight) {
            final sightTitle = sight.name.toLowerCase();
            final input = query.toLowerCase();

            return sightTitle.contains(input);
          }).toSet();
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
          PlaceInteractor.filtersWithDistance = PlaceInteractor.filtersWithDistance.where((sight) {
            final sightTitle = sight.name.toLowerCase();
            final input = query.toLowerCase();

            return sightTitle.contains(input);
          }).toSet();
        }
      }
    }

    if (controller.text.isEmpty) {
      PlaceInteractor.filteredPlaces.clear();
    }
  }
}
