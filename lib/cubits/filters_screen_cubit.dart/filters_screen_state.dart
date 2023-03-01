part of 'filters_screen_cubit.dart';

class FiltersScreenState extends Equatable {
  final bool isEnabled;

  @override
  List<Object?> get props => [isEnabled];

  const FiltersScreenState({
    required this.isEnabled,
  });
}
