part of 'filters_screen_bloc.dart';

abstract class FiltersScreenState extends Equatable {
  @override
  List<Object?> get props => [];
  const FiltersScreenState();
}

class IsNotEnabledState extends FiltersScreenState {
  final int filterIndex;
  final bool isEnabled;

  @override
  List<Object?> get props => [filterIndex, isEnabled];

  const IsNotEnabledState({
    required this.filterIndex,
    required this.isEnabled,
  });
}

class IsEnabledState extends FiltersScreenState {
  final int filterIndex;
  final bool isEnabled;

  @override
  List<Object?> get props => [filterIndex, isEnabled];

  const IsEnabledState({
    required this.filterIndex,
    required this.isEnabled,
  });
}
