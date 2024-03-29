import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:places/data/api/api_places.dart';
import 'package:places/data/database/database.dart';
import 'package:places/data/dto/place_request.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/category.dart';
import 'package:places/data/repository/mapper.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/data/store/app_preferences.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/utils/place_type.dart';

part 'filters_screen_event.dart';
part 'filters_screen_state.dart';

class FiltersScreenBloc extends Bloc<FiltersScreenEvent, FiltersScreenState> {
  static final List<Category> filters = [
    Category(
      title: AppStrings.hotel,
      assetName: AppAssets.hotel,
      placeType: PlaceType.hotel,
      isEnabled: AppPreferences.getCategoryByStatus(PlaceType.hotel),
    ),
    Category(
      title: AppStrings.restaurant,
      assetName: AppAssets.restaurant,
      placeType: PlaceType.restaurant,
      isEnabled: AppPreferences.getCategoryByStatus(PlaceType.restaurant),
    ),
    Category(
      title: AppStrings.particularPlace,
      assetName: AppAssets.particularPlace,
      placeType: PlaceType.other,
      isEnabled: AppPreferences.getCategoryByStatus(PlaceType.other),
    ),
    Category(
      title: AppStrings.park,
      assetName: AppAssets.park,
      placeType: PlaceType.park,
      isEnabled: AppPreferences.getCategoryByStatus(PlaceType.park),
    ),
    Category(
      title: AppStrings.museum,
      assetName: AppAssets.museum,
      placeType: PlaceType.museum,
      isEnabled: AppPreferences.getCategoryByStatus(PlaceType.museum),
    ),
    Category(
      title: AppStrings.cafe,
      assetName: AppAssets.cafe,
      placeType: PlaceType.cafe,
      isEnabled: AppPreferences.getCategoryByStatus(PlaceType.cafe),
    ),
  ];

  final interactor = PlaceInteractor(
    repository: PlaceRepository(
      apiPlaces: ApiPlaces(),
    ),
  );

  FiltersScreenBloc() : super(const FiltersScreenState(filterIndex: 0, isEnabled: false)) {
    on<AddRemoveFilterEvent>(
      (event, emit) {
        if (event.isEnabled) {
          addToActiveFilters(category: event.category);
          emit(
            state.copyWith(
              filterIndex: event.categoryIndex,
              isEnabled: event.isEnabled,
            ),
          );
        } else {
          removeFromFavorites(category: event.category);
          emit(
            state.copyWith(
              filterIndex: event.categoryIndex,
              isEnabled: event.isEnabled,
            ),
          );
        }
      },
    );

    on<ClearAllFiltersEvent>((event, emit) {
      clearAllFilters();
      disableAllCategories();
      emit(
        const FiltersScreenState(
          filterIndex: 0,
          isEnabled: false,
        ),
      );
    });
  }

  Future<void> disableAllCategories() async {
    for (final category in filters) {
      await AppPreferences.setCategoryByName(title: category.placeType.toString(), isEnabled: false);
    }
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

  Future<void> addToFilteredList({required Category category, required List<DbPlace> filteredByType}) async {
    if (!category.isEnabled) {
      // Если категория не активна, добавляю отфильтрованные по категории места filteredByType
      // В список вообще отфильтрованных мест
      PlaceInteractor.initialFilteredPlaces.addAll(filteredByType);
      await savePlaces();
      debugPrint('🟡---------Добавленные места (фильтр вкл.): ${PlaceInteractor.initialFilteredPlaces}');
    } else {
      // Если категория активна, удаляю из списка вообще отфильтрованных мест только те места
      // Тип которых соответствует заявленному фильтру
      // фильтр передаётся из списка, значит он под верным индексом
      PlaceInteractor.initialFilteredPlaces.removeWhere((place) => place.placeType.contains(category.placeType));
      await savePlaces();
      debugPrint('Длина списка с дистанцией: ${PlaceInteractor.filtersWithDistance.length}');
      debugPrint(
        '🟡---------Количество добавленных мест (фильтр откл.): ${PlaceInteractor.initialFilteredPlaces.length}',
      );
    }
  }

  Future<void> savePlaces() async {
    final filteredByType = Mapper.getFiltersWithDistance(PlaceInteractor.initialFilteredPlaces.toSet());
    // Кодирую список в строку Json
    final jsonString = PlaceRequest.encode(filteredByType);

    // Сохраняю данную строку в Shared Preferences
    await AppPreferences.setPlacesListByType(jsonString);

    debugPrint('encodedData: ${jsonString.length}');
  }

  void clearAllFilters() {
    filters.map((e) => e.isEnabled = false).toList();
    PlaceInteractor.activeFilters.removeWhere((element) => true);
    PlaceInteractor.filtersWithDistance.clear();
  }
}
