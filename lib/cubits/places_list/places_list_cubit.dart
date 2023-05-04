import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/api/api_places.dart';
import 'package:places/data/database/database.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/repository/place_repository.dart';

part 'places_list_state.dart';

class PlacesListCubit extends Cubit<PlacesListState> {
  final bool readOnly = true;
  final isSearchPage = false;
  final isPortrait = true;
  final interactor = PlaceInteractor(
    repository: PlaceRepository(
      apiPlaces: ApiPlaces(),
    ),
  );
  List<DbPlace> places = [];
  bool isAddPlaceBtnVisible = true;
  DbPlace? tappedPlacemark;

  PlacesListCubit() : super(PlacesListEmptyState());

  Future<void> getPlaces() async {
    try {
      emit(PlaceListLoadingState());
      places = await interactor.getPlaces();
      emit(PlacesListLoadedState(
        places: places,
      ));
    } on DioError catch (e) {
      emit(PlacesListErrorState(error: e.message));
    }
  }

  void choosePlace(DbPlace place) {
    if (tappedPlacemark != place) {
      isAddPlaceBtnVisible = false;
      tappedPlacemark = place;
    } else {
      isAddPlaceBtnVisible = true;
      tappedPlacemark = null;
    }
    emit(
      PlacesListLoadedState(
        places: places,
        isAddPlaceBtnVisible: isAddPlaceBtnVisible,
        tappedPlacemark: tappedPlacemark,
      ),
    );
  }
}
