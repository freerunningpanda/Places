part of 'choose_category_bloc.dart';

abstract class CategoryEvent {}

class AddCategoryEvent extends CategoryEvent {
  final Category category;
  final bool isEnabled;
  final int index;

  AddCategoryEvent({
    required this.category,
    required this.isEnabled,
    required this.index,
  });
}

class RemoveCategoryEvent extends CategoryEvent {
  final Category category;
  final bool isEnabled;
  final int index;

  RemoveCategoryEvent({
    required this.category,
    required this.isEnabled,
    required this.index,
  });
}
