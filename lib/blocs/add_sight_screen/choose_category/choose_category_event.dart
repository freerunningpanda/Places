part of 'choose_category_bloc.dart';

abstract class CategoryEvent {}

class AddCategoryEvent extends CategoryEvent {
  final Category category;
  final bool isEnabled;

  AddCategoryEvent({
    required this.category,
    required this.isEnabled,
  });
}

class RemoveCategoryEvent extends CategoryEvent {
  final Category category;
  final bool isEnabled;

  RemoveCategoryEvent({
    required this.category,
    required this.isEnabled,
  });
}
