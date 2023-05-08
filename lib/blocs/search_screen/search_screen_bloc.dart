import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:places/data/api/api_places.dart';
import 'package:places/data/database/database.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/data/store/app_preferences.dart';
import 'package:places/mocks.dart';

part 'search_screen_event.dart';
part 'search_screen_state.dart';

class SearchScreenBloc extends Bloc<SearchScreenEvent, SearchScreenState> {
  bool hasFocus = false;
  PlaceInteractor interactor = PlaceInteractor(
    repository: PlaceRepository(
      apiPlaces: ApiPlaces(),
    ),
  );

  SearchScreenBloc() : super(SearchScreenEmptyState()) {
    activeFocus(isActive: true);
    on<PlacesFoundEvent>((event, emit) async {
      await searchPlaces(interactor.query, event.db);
      emitPlacesFoundState(event, emit);
      emitEmptyStateIfNoPlacesFound(event, emit);
      emitAllFilteredPlacesIfQueryEmpty(event, emit);
      await emitFilteredPlacesIfHistoryClear(event, emit);
    });

    on<PlacesNoGeoEvent>((event, emit) async {
      await searchPlacesNoGeo(interactor.query, event.db);
      emit(
        SearchScreenPlacesFoundState(
          filteredPlaces: event.filteredPlaces ?? [],
          length: event.filteredPlaces!.length,
        ),
      );

      if (!event.isQueryEmpty && PlaceInteractor.foundedPlaces.isEmpty) {
        emit(SearchScreenEmptyState());
      }
      if (event.isQueryEmpty || event.searchHistoryIsEmpty) {
        emit(
          SearchScreenPlacesFoundState(
            filteredPlaces: event.filteredPlaces!.toList(),
            length: AppPreferences.getPlacesListByType()?.length ?? 0,
          ),
        );
      }
      if (event.isHistoryClear) {
        emit(
          SearchScreenPlacesFoundState(
            filteredPlaces: event.isHistoryClear ? event.filteredPlaces!.toList() : PlaceInteractor.foundedPlaces,
            length: await loadFilteredPlaces(event.db),
          ),
        );
      }
    });
  }

  void emitPlacesFoundState(PlacesFoundEvent event, Emitter emit) {
    emit(SearchScreenPlacesFoundState(
      filteredPlaces: event.filteredPlaces ?? [],
      length: event.filteredPlaces!.length,
    ));
  }

  void emitEmptyStateIfNoPlacesFound(PlacesFoundEvent event, Emitter emit) {
    if (!event.isQueryEmpty && PlaceInteractor.foundedPlaces.isEmpty) {
      emit(SearchScreenEmptyState());
    }
  }

  void emitAllFilteredPlacesIfQueryEmpty(PlacesFoundEvent event, Emitter emit) {
    if (event.isQueryEmpty || event.searchHistoryIsEmpty) {
      emit(SearchScreenPlacesFoundState(
        filteredPlaces: event.filteredPlaces!.toList(),
        length: AppPreferences.getPlacesListByDistance()?.length ?? 0,
      ));
    }
  }

  Future<void> emitFilteredPlacesIfHistoryClear(PlacesFoundEvent event, Emitter emit) async {
    if (event.isHistoryClear) {
      emit(SearchScreenPlacesFoundState(
        filteredPlaces: event.isHistoryClear ? event.filteredPlaces!.toList() : PlaceInteractor.foundedPlaces,
        length: await loadFilteredPlaces(event.db),
      ));
    }
  }

  void activeFocus({required bool isActive}) {
    // ignore: prefer-conditional-expressions
    if (isActive) {
      interactor.hasFocus = true;
    } else {
      interactor.hasFocus = false;
    }
  }

  Future<List<DbPlace>> searchPlaces(String query, AppDb db) async {
    final placesList = await db.allPlacesEntries;
    final position = await Geolocator.getCurrentPosition();
    PlaceInteractor.foundedPlaces = placesList.where(
      (place) {
        final distance = Geolocator.distanceBetween(
          position.latitude,
          position.longitude,
          place.lat,
          place.lng,
        );
        final placeTitle = place.name.toLowerCase();
        final input = query.toLowerCase();

        return distance >= Mocks.rangeValues.start && distance <= Mocks.rangeValues.end && placeTitle.contains(input);
      },
    ).toList();

    return PlaceInteractor.foundedPlaces;
  }

  Future<List<DbPlace>> searchPlacesNoGeo(String query, AppDb db) async {
    final placesList = await db.allPlacesEntries;
    PlaceInteractor.foundedPlaces = placesList.where(
      (place) {
        final placeTitle = place.name.toLowerCase();
        final input = query.toLowerCase();

        return placeTitle.contains(input);
      },
    ).toList();

    return PlaceInteractor.foundedPlaces;
  }
}

Future<int> loadFilteredPlaces(AppDb db) async {
  final placesList = await db.allPlacesEntries;

  return placesList.length;
}
