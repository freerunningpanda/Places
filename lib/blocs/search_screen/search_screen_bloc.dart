import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:places/data/api/api_places.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place.dart';
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
    searchPlaces(interactor.query);
    on<PlacesFoundEvent>((event, emit) {
      debugPrint('Длина списка мест после поиска: ${PlaceInteractor.foundedPlaces.length}');
      emit(
        SearchScreenPlacesFoundState(
          filteredPlaces: event.fromFiltersScreen ? event.filteredPlaces!.toList() : PlaceInteractor.foundedPlaces,
          length: AppPreferences.getPlacesListByDistance()?.length ?? 0,
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
            length: AppPreferences.getPlacesListByDistance()?.length ?? 0,
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

  void searchPlaces(String query) {
    final placesList = AppPreferences.getPlacesListByDistance();
    // Если список мест в Preferences не null, искать в нём
    // Данное решение, для того, чтобы не ловить крэш после удаления/установки приложения
    if (placesList != null) {
      for (final el in placesList) {
        final distance = Geolocator.distanceBetween(
          Mocks.mockLat,
          Mocks.mockLot,
          el.lat,
          el.lng,
        );
        if (distance >= Mocks.rangeValues.start && distance <= Mocks.rangeValues.end) {
          PlaceInteractor.foundedPlaces = AppPreferences.getPlacesListByDistance()!.where((place) {
            final placeTitle = place.name.toLowerCase();
            final input = query.toLowerCase();
            debugPrint('filteredPlaces: ${PlaceInteractor.foundedPlaces}');

            return placeTitle.contains(input);
          }).toList();
        }
      }
    } 
  }
}
