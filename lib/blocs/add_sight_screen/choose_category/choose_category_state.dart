part of 'choose_category_bloc.dart';

abstract class ChooseCategoryState extends Equatable {
  @override
  List<Object?> get props => [];
  const ChooseCategoryState();
}

class ChosenCategoryState extends ChooseCategoryState {
  final Category? selectedCategory;
  final bool isEnabled;
  final int index;

  @override
  List<Object?> get props => [selectedCategory];

  const ChosenCategoryState({
    this.selectedCategory,
    required this.isEnabled,
    required this.index,
  });

  ChosenCategoryState copyWith({
    Category? selectedCategory,
    bool? isEnabled,
    int? index,
  }) {
    return ChosenCategoryState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      isEnabled: isEnabled ?? this.isEnabled,
      index: index ?? this.index,
    );
  }
}

class NotChosenCategoryState extends ChooseCategoryState {
  final Category? selectedCategory;
  final bool isEnabled;
  final int index;

  @override
  List<Object?> get props => [selectedCategory];

  const NotChosenCategoryState({
    this.selectedCategory,
    required this.isEnabled,
    required this.index,
  });

  NotChosenCategoryState copyWith({
    Category? selectedCategory,
    bool? isEnabled,
    int? index,
  }) {
    return NotChosenCategoryState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      isEnabled: isEnabled ?? this.isEnabled,
      index: index ?? this.index,
    );
  }
}
