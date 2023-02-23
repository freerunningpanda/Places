part of 'chosen_category_bloc.dart';

abstract class ChosenEvent {}

class ChosenCategoryEvent extends ChosenEvent {
  final List<Category> activeCategories;
  final bool isEmpty;

  ChosenCategoryEvent({
    required this.isEmpty,
    required this.activeCategories,
  });
}

class ClearCategoryEvent extends ChosenEvent {
  final List<Category> activeCategories;
  final bool isEmpty;

  ClearCategoryEvent({
    required this.activeCategories,
    required this.isEmpty,
  });
}
