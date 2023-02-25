part of 'choose_category_bloc.dart';

class ChooseCategoryState extends Equatable {
  final bool isEmpty;
  final Category? chosenCategory;

  @override
  List<Object?> get props => [isEmpty, chosenCategory];

  const ChooseCategoryState({
    required this.isEmpty,
    this.chosenCategory,
  });
}
