part of 'filters_screen_bloc.dart';

abstract class FiltersScreenState extends Equatable {
  @override
  List<Object?> get props => [];
}

class IsNotEnabledState extends FiltersScreenState {
  final int filterIndex;

  @override
  List<Object?> get props => [filterIndex];

  IsNotEnabledState({
    required this.filterIndex,
  });
}

class IsEnabledState extends FiltersScreenState {
  final int filterIndex;

  @override
  List<Object?> get props => [filterIndex];

  IsEnabledState({
    required this.filterIndex,
  });
}
