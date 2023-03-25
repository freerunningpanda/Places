part of 'filters_screen_bloc.dart';

class FiltersScreenState extends Equatable {
  final int filterIndex;
  final bool isEnabled;

  @override
  List<Object?> get props => [filterIndex, isEnabled];

  const FiltersScreenState({
    required this.filterIndex,
    required this.isEnabled,
  });

  FiltersScreenState copyWith({
    int? filterIndex,
    bool? isEnabled,
  }) {
    return FiltersScreenState(
      filterIndex: filterIndex ?? this.filterIndex,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }
}
