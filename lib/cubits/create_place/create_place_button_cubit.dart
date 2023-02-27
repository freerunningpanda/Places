import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/api/api_places.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/category.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/providers/category_data_provider.dart';

part 'create_place_button_state.dart';

class CreatePlaceButtonCubit extends Cubit<CreatePlaceButtonState> {
  final PlaceInteractor placeInteractor = PlaceInteractor(repository: PlaceRepository(apiPlaces: ApiPlaces()));
  final chosenCategory = CategoryDataProvider.chosenCategory;
  String name = '';
  double lat = 0;
  double lot = 0;
  String details = '';
  String type = '';
  CreatePlaceButtonCubit()
      : super(
          const CreatePlaceButtonState(
            chosenCategory: [],
            descriptionValue: '',
            latValue: '',
            lotValue: '',
            titleValue: '',
          ),
        );

  // void addNewPlace({
  //   required String titleValue,
  //   required String descriptionValue,
  //   required String latValue,
  //   required String lotValue,
  // }) {
  //   placeInteractor.addNewPlace(
  //     place: Place(
  //       id: 0,
  //       urls: [''],
  //       name: name,
  //       lat: lat,
  //       lng: lot,
  //       description: details,
  //       placeType: chosenCategory[0].title,
  //     ),
  //   );
  //   emit(
  //     CreatePlaceButtonState(
  //       chosenCategory: chosenCategory.isEmpty,
  //       titleValue: titleValue.isEmpty,
  //       descriptionValue: descriptionValue.isEmpty,
  //       latValue: latValue.isEmpty,
  //       lotValue: lotValue.isEmpty,
  //     ),
  //   );
  // }

  void updateButtonState({
    required String titleValue,
    required String descriptionValue,
    required String latValue,
    required String lotValue,
  }) {
    emit(
      CreatePlaceButtonState(
        chosenCategory: chosenCategory,
        titleValue: titleValue,
        descriptionValue: descriptionValue,
        latValue: latValue,
        lotValue: lotValue,
      ),
    );
  }
}
