import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:places/data/api/api_places.dart';
import 'package:places/data/database/database.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/category.dart';
import 'package:places/data/repository/category_repository.dart';
import 'package:places/data/repository/place_repository.dart';

part 'create_place_button_state.dart';

class CreatePlaceButtonCubit extends Cubit<CreatePlaceButtonState> {
  final PlaceInteractor placeInteractor = PlaceInteractor(repository: PlaceRepository(apiPlaces: ApiPlaces()));
  final chosenCategory = CategoryRepository.chosenCategories;
  String name = '';
  double lat = 0;
  double lng = 0;
  String description = '';
  String placeType = '';
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

  void addNewPlace(DbPlace place) {
    placeInteractor.postPlace(
      place: DbPlace(
        id: place.id,
        lat: place.lat,
        lng: place.lng,
        name: place.name,
        urls: place.urls,
        placeType: place.placeType,
        description: place.description,
      ),
      urls: PlaceInteractor.urls,
    );
    // placeInteractor.addNewPlace(place: place);
  }

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

  // Метод отвечающий за изменение состояния кнопки создания нового места
  bool buttonStyle({required CreatePlaceButtonState state}) {
    return state.chosenCategory.isEmpty ||
        state.titleValue.isEmpty ||
        state.descriptionValue.isEmpty ||
        state.latValue.isEmpty ||
        state.lotValue.isEmpty;
  }
}
