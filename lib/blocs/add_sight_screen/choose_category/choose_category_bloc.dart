import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/category.dart';
import 'package:places/providers/category_data_provider.dart';

part 'choose_category_event.dart';
part 'choose_category_state.dart';

class ChooseCategoryBloc extends Bloc<CategoryEvent, ChooseCategoryState> {
  ChooseCategoryBloc() : super(const ChooseCategoryState()) {
    on<CategoryEvent>(
      (event, emit) {
        addToActive(category: event.category);
        emit(
          state.copyWith(selectedCategory: event.category),
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
}