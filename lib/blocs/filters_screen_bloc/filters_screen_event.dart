part of 'filters_screen_bloc.dart';

abstract class FiltersScreenEvent {
  const FiltersScreenEvent();
}

class AddRemoveFilterEvent extends FiltersScreenEvent {
  final Category category;
  final bool isEnabled;
  final int categoryIndex;

  const AddRemoveFilterEvent({
    required this.category,
    required this.isEnabled,
    required this.categoryIndex,
  });
}

class ClearAllFiltersEvent extends FiltersScreenEvent {}
