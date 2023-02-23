part of 'chosen_category_bloc.dart';

abstract class ChosenCategoryState extends Equatable {
  @override
  List<Object?> get props => [];

  const ChosenCategoryState();
}

class ChosenCategoryIsChooseState extends ChosenCategoryState {
  final bool isEmpty;
  final int length;

  @override
  List<Object?> get props => [isEmpty, length];

  const ChosenCategoryIsChooseState({
    required this.isEmpty,
    required this.length,
  });
}

class ChosenCategoryNotChooseState extends ChosenCategoryState {
  final bool isEmpty;
  final int length;

  @override
  List<Object?> get props => [isEmpty, length];

  const ChosenCategoryNotChooseState({
    required this.isEmpty,
    required this.length,
  });
}
