part of 'choose_category_bloc.dart';

abstract class ChooseCategoryEvent {}

class ChosenCategoryEvent extends ChooseCategoryEvent {
  final bool isEmpty;
  final Category chosenCategory; // Чтобы в стэйт прокинуть имя выбранной категории
  final String placeType;

  ChosenCategoryEvent({
    required this.isEmpty,
    required this.chosenCategory,
    required this.placeType,
  });
}

class UnchosenCategoryEvent extends ChooseCategoryEvent {
  final bool isEmpty;

  UnchosenCategoryEvent({
    required this.isEmpty,
  });
}
