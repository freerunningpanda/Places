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
  FiltersScreenBloc() : super(IsNotEnabledState(filterIndex: 0)) {
    on<FiltersScreenEvent>(
      (event, emit) {
        if (event.isEnabled) {
          addToActiveFilters(category: event.category);
          emit(
            IsEnabledState(filterIndex: event.categoryIndex),
          );
        } else {
          removeFromFavorites(category: event.category);
          emit(
            IsNotEnabledState(filterIndex: event.categoryIndex),
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
      PlaceInteractor.filteredMocks.addAll(filteredByType);
    } else {
      PlaceInteractor.filteredMocks.clear();
      PlaceInteractor.filtersWithDistance.clear();
      debugPrint('🟡---------Добавленные места: ${PlaceInteractor.filteredMocks}');
    }
  }
}
