part of 'filters_screen_bloc.dart';

class FiltersScreenEvent {
  final Category category;
  final bool isEnabled;
  final int categoryIndex;

  FiltersScreenEvent({
    required this.category,
    required this.isEnabled,
    required this.categoryIndex,
  });
}

