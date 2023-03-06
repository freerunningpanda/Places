import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:places/data/api/api_places.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/category.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/utils/place_type.dart';

part 'filters_screen_event.dart';
part 'filters_screen_state.dart';

class FiltersScreenBloc extends Bloc<FiltersScreenEvent, FiltersScreenState> {
  static final List<Category> filters = [
    Category(title: AppString.hotel, assetName: AppAssets.hotel, placeType: PlaceType.hotel),
    Category(
      title: AppString.restaurant,
      assetName: AppAssets.restaurant,
      placeType: PlaceType.restaurant,
    ),
    Category(title: AppString.particularPlace, assetName: AppAssets.particularPlace, placeType: PlaceType.other),
    Category(title: AppString.park, assetName: AppAssets.park, placeType: PlaceType.park),
    Category(title: AppString.museum, assetName: AppAssets.museum, placeType: PlaceType.museum),
    Category(title: AppString.cafe, assetName: AppAssets.cafe, placeType: PlaceType.cafe),
  ];

  final interactor = PlaceInteractor(
    repository: PlaceRepository(
      apiPlaces: ApiPlaces(),
    ),
  );
  FiltersScreenBloc() : super(IsNotEnabledState(filterIndex: 0, isEnabled: false)) {
    on<AddRemoveFilterEvent>(
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

    on<ClearAllFiltersEvent>((event, emit) {
      clearAllFilters();
      emit(
        IsNotEnabledState(
          filterIndex: 0,
          isEnabled: false,
        ),
      );
    });
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
      PlaceInteractor.initialFilteredPlaces.addAll(filteredByType);
      debugPrint('🟡---------Добавленные места (фильтр вкл.): ${PlaceInteractor.initialFilteredPlaces}');
    } else {
      // Если категория активна, удаляю из списка вообще отфильтрованных мест только те места
      // Тип которых соответствует заявленному фильтру
      // фильтр передаётся из списка, значит он под верным индексом
      PlaceInteractor.initialFilteredPlaces.removeWhere((place) => place.placeType.contains(category.placeType));
      debugPrint('Длина списка с дистанцией: ${PlaceInteractor.filtersWithDistance.length}');
      // emit(state);
      PlaceInteractor.filtersWithDistance.clear(); // Дописать
      debugPrint(
        '🟡---------Количество добавленных мест (фильтр откл.): ${PlaceInteractor.initialFilteredPlaces.length}',
      );
    }
  }

  void clearAllFilters() {
    filters.map((e) => e.isEnabled = false).toList();
    PlaceInteractor.activeFilters.removeWhere((element) => true);
    PlaceInteractor.filtersWithDistance.clear();
  }
}
