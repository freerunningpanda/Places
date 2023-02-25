import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/model/category.dart';

part 'choose_category_event.dart';
part 'choose_category_state.dart';

class ChooseCategoryBloc extends Bloc<ChooseCategoryEvent, ChooseCategoryState> {
  ChooseCategoryBloc() : super(const ChooseCategoryState(isEmpty: true)) {
    on<ChosenCategoryEvent>(
      (event, emit) => emit(
        ChooseCategoryState(
          isEmpty: event.isEmpty,
          chosenCategory: event.chosenCategory,
        ),
      ),
    );
    on<UnchosenCategoryEvent>(
      (event, emit) => emit(
        ChooseCategoryState(
          isEmpty: event.isEmpty,
        ),
      ),
    );
  }


    // Раньше не работало, потому что я с ивента прокидывал в этот метод значения и вызывал его в методе on
    // Нужно было просто его вызывать через context
    List<Category> chooseCategory({
    required int index,
    required List<Category> categories,
    required List<Category> activeCategories,
  }) {
    final category = categories[index];
    final activeCategory = activeCategories;
    var isEnabled = !categories[index].isEnabled;
    isEnabled = !isEnabled;
    for (final i in categories) {
      if (!isEnabled) {
        activeCategory.add(category);
        category.isEnabled = true;
        i.isEnabled = false;
        activeCategory
          ..clear()
          ..add(category);
        debugPrint('🟡--------- Выбрана категория: ${category.title}');
        category.isEnabled = true;
      } else {
        category.isEnabled = false;
        activeCategory.clear();
      }
    }

    return activeCategory;
  }
}
