part of 'choose_category_bloc.dart';

abstract class ChooseCategoryState extends Equatable {
  @override
  List<Object?> get props => [];
  const ChooseCategoryState();
}

class ChosenCategoryState extends ChooseCategoryState {
  final Category? selectedCategory;
  final bool isEnabled;

  @override
  List<Object?> get props => [selectedCategory];

  const ChosenCategoryState({
    this.selectedCategory,
    required this.isEnabled,
  });

  ChosenCategoryState copyWith({
    Category? selectedCategory,
    bool? isEnabled,
  }) {
    return ChosenCategoryState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }
}

class NotChosenCategoryState extends ChooseCategoryState {
  final Category? selectedCategory;
  final bool isEnabled;

  @override
  List<Object?> get props => [selectedCategory];

  const NotChosenCategoryState({
    this.selectedCategory,
    required this.isEnabled,
  });

  NotChosenCategoryState copyWith({
    Category? selectedCategory,
    bool? isEnabled,
  }) {
    return NotChosenCategoryState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }
}
