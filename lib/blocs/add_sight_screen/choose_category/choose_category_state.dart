part of 'choose_category_bloc.dart';

class ChooseCategoryState extends Equatable {
  final Category? selectedCategory;

  @override
  List<Object?> get props => [selectedCategory];

  const ChooseCategoryState({
    this.selectedCategory,
  });

  ChooseCategoryState copyWith({
    Category? selectedCategory,
  }) {
    return ChooseCategoryState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}
