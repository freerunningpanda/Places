import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/model/category.dart';
import 'package:places/providers/category_data_provider.dart';

part 'chosen_category_event.dart';
part 'chosen_category_state.dart';

class ChosenCategoryBloc extends Bloc<ChosenEvent, ChosenCategoryState> {
  final chosenCategory = CategoryDataProvider.chosenCategory;
  ChosenCategoryBloc() : super(const ChosenCategoryNotChooseState(isEmpty: true, length: 0)) {
    on<ChosenCategoryEvent>(
      (event, emit) {
        emit(
          ChosenCategoryIsChooseState(
            isEmpty: event.isEmpty,
            length: event.activeCategories.length,
          ),
        );
      },
    );
    on<ClearCategoryEvent>(
      (event, emit) {
        clearCategory(activeCategories: event.activeCategories);
        emit(
          ChosenCategoryNotChooseState(
            isEmpty: event.isEmpty,
            length: event.activeCategories.length,
          ),
        );
      },
    );
  }

  void clearCategory({required List<Category> activeCategories}) {
    for (final i in activeCategories) {
      i.isEnabled = false;
    }
    activeCategories.clear();
  }
}
