import 'package:equatable/equatable.dart';
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
}
