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
      debugPrint('Длина списка мест после поиска: ${PlaceInteractor.foundedPlaces.length}');
      emit(
        SearchScreenPlacesFoundState(
          filteredPlaces: event.fromFiltersScreen ? event.filteredPlaces!.toList() : PlaceInteractor.foundedPlaces,
          length: PlaceInteractor.filtersWithDistance.length,
        ),
      );
      // Если поисковый запрос пуст, то показывать все найденные по фильтрам места
      // Теперь не будет отображаться пустое состояние, потому что сработает данное условие
      // И в стэйт прокинутся отфильтрованные места
      if (event.isQueryEmpty) {
        emit(
          SearchScreenPlacesFoundState(
            filteredPlaces: PlaceInteractor.filtersWithDistance.toList(),
            length: PlaceInteractor.filtersWithDistance.length,
          ),
        );
      // Иначе если поисковый запрос содержит значение и список найденных мест пуст
      // Эмитим пустое состояние экрана
      } else if (!event.isQueryEmpty && PlaceInteractor.foundedPlaces.isEmpty) {
        emit(SearchScreenEmptyState());
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
            filteredPlaces:
                event.isHistoryClear ? PlaceInteractor.filtersWithDistance.toList() : PlaceInteractor.foundedPlaces,
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
    for (final el in PlaceInteractor.filtersWithDistance) {
      final distance = Geolocator.distanceBetween(
        Mocks.mockLat,
        Mocks.mockLot,
        el.lat,
        el.lng,
      );
      if (distance >= Mocks.rangeValues.start && distance <= Mocks.rangeValues.end) {
        PlaceInteractor.foundedPlaces = PlaceInteractor.filtersWithDistance.where((sight) {
          final sightTitle = sight.name.toLowerCase();
          final input = query.toLowerCase();
          debugPrint('filteredPlaces: $PlaceInteractor.foundedPlaces');

          return sightTitle.contains(input);
        }).toList();
      }
    }

    if (controller.text.isEmpty) {
      PlaceInteractor.foundedPlaces.clear();
    }
  }
}
