import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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
      // debugPrint('Длина списка мест после поиска: ${PlaceInteractor.foundedPlaces.length}');
      emit(
        SearchScreenPlacesFoundState(
          filteredPlaces: event.filteredPlaces ?? [],
          // filteredPlaces: PlaceInteractor.foundedPlaces,
          length: event.filteredPlaces!.length,
          // length: AppPreferences.getPlacesListByDistance()?.length ?? 0,
        ),
      );
      // Если поисковый запрос содержит значение и список найденных мест пуст
      // Эмитим пустое состояние экрана

      // P.S.: когда данное условие стояло ниже следующего условия
      // Оно не дёргалось и пустой стэйт не эмитился после ввода имени места
      // Которого в списке нет. Не понятно почему
      // Сейчас перенёс его сюда и оно срабатывает

      if (!event.isQueryEmpty && PlaceInteractor.foundedPlaces.isEmpty) {
        emit(SearchScreenEmptyState());
      }
      // Если поисковый запрос пуст, то показывать все найденные по фильтрам места
      // Теперь не будет отображаться пустое состояние, потому что сработает данное условие
      // И в стэйт прокинутся отфильтрованные места
      if (event.isQueryEmpty || event.searchHistoryIsEmpty) {
        emit(
          SearchScreenPlacesFoundState(
            filteredPlaces: event.filteredPlaces!.toList(),
            length: AppPreferences.getPlacesListByDistance()?.length ?? 0,
          ),
        );
      }

      // Предыдущее условие показывало пустой стэйт, потому что не было проверки
      // На то, пустой запрос или нет. Поэтому при завершении поиска состоянием пустого экрана
      // Возвратом на экран фильтров, затем снова на экран поиска - отображался экран ненайденных мест
      // Решилось добавлением условия !event.isQueryEmpty - отвечающего за проверку строки поиска.
      // Теперь пустое состояние покажется только в случае, когда в строке есть значение не соответсвующее имени места
      // А до этого показывалось всегда, так как список найденных мест был пуст, если места не были найдены
      // Что при дальнейшем использовании вызывало пустой стэйт, при переходе снова с экрана фильтров
      // На экран поиска мест, с отфильтрованными местами
      // if (PlaceInteractor.foundedPlaces.isEmpty) {
      //   emit(SearchScreenEmptyState());
      // }
      if (event.isHistoryClear) {
        emit(
          SearchScreenPlacesFoundState(
            filteredPlaces: event.isHistoryClear ? event.filteredPlaces!.toList() : PlaceInteractor.foundedPlaces,
            length: await loadFilteredPlaces(event.db),
            // length: AppPreferences.getPlacesListByDistance()?.length ?? 0,
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

  Future<List<DbPlace>> searchPlaces(String query, AppDb db) async {
    final placesList = await db.allPlacesEntries;
    PlaceInteractor.foundedPlaces = placesList.where(
      (place) {
        final distance = Geolocator.distanceBetween(
          Mocks.mockLat,
          Mocks.mockLot,
          place.lat,
          place.lng,
        );
        final placeTitle = place.name.toLowerCase();
        final input = query.toLowerCase();

        return distance >= Mocks.rangeValues.start && distance <= Mocks.rangeValues.end && placeTitle.contains(input);
      },
    ).toList();

    // Сохранить найденные места в бд
    // for (final place in filteredPlaces) {
    //   await db.addPlace(place, isSearchScreen: true);
    // }

    return PlaceInteractor.foundedPlaces;
  }
}

Future<int> loadFilteredPlaces(AppDb db) async {
  final placesList = await db.allPlacesEntries;

  return placesList.length;
}
