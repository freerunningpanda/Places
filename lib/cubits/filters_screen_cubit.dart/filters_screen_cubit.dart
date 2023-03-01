import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/providers/filter_data_provider.dart';

part 'filters_screen_state.dart';

class FiltersScreenCubit extends Cubit<FiltersScreenState> {
  bool isEnabled = false;
  FiltersScreenCubit() : super(const FiltersScreenState(isEnabled: false));

  List<String> saveFilters(int index) {
    final filters = FilterDataProvider.filters[index];
    final activeFilters = PlaceInteractor.activeFilters;
    var isEnabled = !FilterDataProvider.filters[index].isEnabled;
    isEnabled = !isEnabled;
    if (!isEnabled) {
      activeFilters.add(filters.title);
      filters.isEnabled = true;

      emit(FiltersScreenState(isEnabled: isEnabled),);
    } else {
      activeFilters.removeLast();
      filters.isEnabled = false;
      emit(FiltersScreenState(isEnabled: isEnabled),);
    }

    return activeFilters;
  }
}
