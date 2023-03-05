import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:places/data/api/api_places.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/category.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/place_repository.dart';

part 'filters_screen_event.dart';
part 'filters_screen_state.dart';

class FiltersScreenBloc extends Bloc<FiltersScreenEvent, FiltersScreenState> {
  final interactor = PlaceInteractor(
    repository: PlaceRepository(
      apiPlaces: ApiPlaces(),
    ),
  );
  FiltersScreenBloc() : super(IsNotEnabledState(filterIndex: 0, isEnabled: false)) {
    on<FiltersScreenEvent>(
      (event, emit) {
        if (event.isEnabled) {
          addToActiveFilters(category: event.category);
          emit(
            IsEnabledState(
              filterIndex: event.categoryIndex,
              isEnabled: event.isEnabled,
            ),
          );
        } else {
          removeFromFavorites(category: event.category);
          emit(
            IsNotEnabledState(
              filterIndex: event.categoryIndex,
              isEnabled: event.isEnabled,
            ),
          );
        }
      },
    );
  }

  void addToActiveFilters({required Category category}) {
    PlaceInteractor.activeFilters.add(category);
    debugPrint('🟡--------- Активна категория: ${PlaceInteractor.activeFilters}');
    debugPrint('🟡--------- Длина: ${PlaceInteractor.activeFilters.length}');
  }

  void removeFromFavorites({required Category category}) {
    PlaceInteractor.activeFilters.remove(category);
    debugPrint('🟡--------- Длина списка активных категорий: ${PlaceInteractor.activeFilters.length}');
    debugPrint('🟡--------- Активна категория: ${PlaceInteractor.activeFilters}');
  }

  void addToFilteredList({required Category category, required List<Place> filteredByType}) {
    if (!category.isEnabled) {
      // Если категория не активна, добавляю отфильтрованные по категории места filteredByType
      // В список вообще отфильтрованных мест
      PlaceInteractor.filteredMocks.addAll(filteredByType);
      debugPrint('🟡---------Добавленные места (фильтр вкл.): ${PlaceInteractor.filteredMocks}');
      debugPrint('🟡---------Добавленные места (дистанция): ${PlaceInteractor.filtersWithDistance}');
      debugPrint('🟡---------Количество добавленных мест (дистанция): ${PlaceInteractor.filtersWithDistance.length}');
    } else {
      // Если категория активна, удаляю из списка вообще отфильтрованных мест только те места
      // Тип которых соответствует заявленному фильтру
      // фильтр передаётся из списка, значит он под верным индексом
      PlaceInteractor.filteredMocks.removeWhere((place) => place.placeType.contains(category.placeType));
      PlaceInteractor.filtersWithDistance.removeWhere((place) => place.placeType.contains(category.placeType));
      debugPrint('Длина списка с дистанцией: ${PlaceInteractor.filtersWithDistance.length}');
      // emit(state);
      PlaceInteractor.filtersWithDistance.clear(); // Дописать
      debugPrint('🟡---------Количество добавленных мест (фильтр откл.): ${PlaceInteractor.filteredMocks.length}');
    }
  }
}
