import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/category.dart';
import 'package:places/providers/category_data_provider.dart';

part 'choose_category_event.dart';
part 'choose_category_state.dart';

class ChooseCategoryBloc extends Bloc<CategoryEvent, ChooseCategoryState> {
  ChooseCategoryBloc()
      : super(
          const NotChosenCategoryState(
            isEnabled: false,
            index: 0,
          ),
        ) {
    on<AddCategoryEvent>(
      (event, emit) {
        addToActive(category: event.category);
        emit(
          ChosenCategoryState(
            isEnabled: event.isEnabled,
            selectedCategory: event.category,
            index: event.index,
          ),
        );
      },
    );
    on<RemoveCategoryEvent>(
      (event, emit) {
        disableCategory(category: event.category);
        emit(
          NotChosenCategoryState(
            isEnabled: event.isEnabled,
            selectedCategory: event.category,
            index: event.index,
          ),
        );
      },
    );
  }

  void addToActive({required Category category}) {
    final chosenCategory = CategoryDataProvider.chosenCategory
      // Добавляю категорию только если список активных категорий пустой
      // Добавляю категорию в список выбранных категорий
      ..add(category);
    if (chosenCategory.length > 1) {
      chosenCategory.removeAt(0);
    }
    debugPrint('🟡--------- Выбрана категория: ${category.title}');
    debugPrint('🟡--------- Длина: ${CategoryDataProvider.chosenCategory.length}');
  }

  void disableCategory({required Category category}) {
    final chosenCategory = CategoryDataProvider.chosenCategory;
    // Удаляю категорию из списка выбранных категорий

    CategoryDataProvider.chosenCategory.clear();
    debugPrint('🟡--------- Удалена категория: ${category.title}');
    debugPrint('🟡--------- Длина: ${CategoryDataProvider.chosenCategory.length}');
  }
}

void clearCategory({required List<Category> activeCategories}) {
  for (final i in activeCategories) {
    i.isEnabled = false;
  }
  activeCategories.clear();
}
