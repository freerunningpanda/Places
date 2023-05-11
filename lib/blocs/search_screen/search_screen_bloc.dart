import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:places/data/api/api_places.dart';
import 'package:places/data/database/database.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/data/store/app_preferences.dart';
import 'package:places/main.dart';
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
      if (status.isDenied) {
        await searchPlacesNoGeo(interactor.query, event.db);
      } else if (status.isGranted) {
        await searchPlaces(interactor.query, event.db);
      }
      emitPlacesFoundState(event, emit);
      emitEmptyStateIfNoPlacesFound(event, emit);
      if (status.isDenied) {
        emitAllFilteredPlacesIfQueryEmptyNoGeo(event, emit);
      } else {
        emitAllFilteredPlacesIfQueryEmpty(event, emit);
      }
      await emitFilteredPlacesIfHistoryClear(event, emit);
    });
  }

  // Эмитить в стэйт найденные места
  void emitPlacesFoundState(PlacesFoundEvent event, Emitter emit) {
    emit(SearchScreenPlacesFoundState(
      filteredPlaces: event.filteredPlaces ?? [],
      length: event.filteredPlaces!.length,
    ));
  }

// Эмитить пустой стэйт
  void emitEmptyStateIfNoPlacesFound(PlacesFoundEvent event, Emitter emit) {
    if (!event.isQueryEmpty && PlaceInteractor.foundedPlaces.isEmpty) {
      emit(SearchScreenEmptyState());
    }
  }

  // Эмитить все отфильтрованные места в стэйт если поисковый запрос пустой
  void emitAllFilteredPlacesIfQueryEmpty(PlacesFoundEvent event, Emitter emit) {
    if (event.isQueryEmpty || event.searchHistoryIsEmpty) {
      emit(SearchScreenPlacesFoundState(
        filteredPlaces: event.filteredPlaces!.toList(),
        length: AppPreferences.getPlacesListByDistance()?.length ?? 0,
      ));
    }
  }

  // Эмитить все отфильтрованные места в стэйт если поисковый запрос пустой. Гео отключено.
  void emitAllFilteredPlacesIfQueryEmptyNoGeo(PlacesFoundEvent event, Emitter emit) {
    if (event.isQueryEmpty || event.searchHistoryIsEmpty) {
      emit(SearchScreenPlacesFoundState(
        filteredPlaces: event.filteredPlaces!.toList(),
        length: AppPreferences.getPlacesListByType()?.length ?? 0,
      ));
    }
  }

  // Эмитить все отфильтрованные места в стэйт если история запросов пуста.
  Future<void> emitFilteredPlacesIfHistoryClear(PlacesFoundEvent event, Emitter emit) async {
    if (event.isHistoryClear) {
      emit(SearchScreenPlacesFoundState(
        filteredPlaces: event.isHistoryClear ? event.filteredPlaces!.toList() : PlaceInteractor.foundedPlaces,
        length: await loadFilteredPlaces(event.db),
      ));
    }
  }

  // Контроль фокуса
  void activeFocus({required bool isActive}) {
    // ignore: prefer-conditional-expressions
    if (isActive) {
      interactor.hasFocus = true;
    } else {
      interactor.hasFocus = false;
    }
  }

  // Поиск мест
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

// Поиск мест. Гео отключено
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

// Загрузить отфильтрованные места из БД.
Future<int> loadFilteredPlaces(AppDb db) async {
  final placesList = await db.allPlacesEntries;

  return placesList.length;
}
