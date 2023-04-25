import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:places/data/api/api_places.dart';
import 'package:places/data/dto/place_model.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/category.dart';
import 'package:places/data/model/create_button_state.dart';
import 'package:places/data/repository/category_repository.dart';
import 'package:places/data/repository/place_repository.dart';

part 'create_place_button_state.dart';

class CreatePlaceButtonCubit extends Cubit<CreatePlaceButtonState> {
  final PlaceInteractor placeInteractor = PlaceInteractor(repository: PlaceRepository(apiPlaces: ApiPlaces()));
  final chosenCategory = CategoryRepository.chosenCategories;
  final uploadedImages = <String>[];
  String name = '';
  double lat = 0;
  double lng = 0;
  String description = '';
  String placeType = '';
  CreatePlaceButtonCubit()
      : super(
          CreatePlaceButtonState(
            chosenCategory: const [],
            descriptionValue: '',
            latValue: '',
            lotValue: '',
            titleValue: '',
            imagesToUpload: const [],
            imagesToUploadLength: PlaceInteractor.urls.length,
          ),
        );

  Future<void> addNewPlace(PlaceModel placeModel) async {
    for (var i = 0; i < PlaceInteractor.urls.length; i++) {
      uploadedImages.add(await placeInteractor.uploadFile(PlaceInteractor.urls[i]));
    }

    final place = PlaceModel(
      lat: placeModel.lat,
      lng: placeModel.lng,
      name: placeModel.name,
      urls: uploadedImages,
      placeType: placeModel.placeType,
      description: placeModel.description,
    );

    await placeInteractor.postPlace(place: place);
  }

  void updateButtonState({required CreateButtonState createButton}) {
    emit(
      state.copyWith(
        chosenCategory: chosenCategory,
        titleValue: createButton.titleValue,
        descriptionValue: createButton.descriptionValue,
        latValue: createButton.latValue,
        lotValue: createButton.lngValue,
        imagesToUpload: PlaceInteractor.urls,
        imagesToUploadLength: PlaceInteractor.urls.length,
      ),
    );
  }

  // Метод отвечающий за изменение состояния кнопки создания нового места
  bool buttonStyle({required CreatePlaceButtonState state}) {
    return state.chosenCategory.isEmpty ||
        state.titleValue.isEmpty ||
        state.descriptionValue.isEmpty ||
        state.latValue.isEmpty ||
        state.lotValue.isEmpty ||
        state.imagesToUpload.isEmpty;
  }

  void removeImage({required int index}) {
    if (PlaceInteractor.urls.isNotEmpty) {
      PlaceInteractor.urls.removeAt(index);
      emit(
        state.copyWith(
          imagesToUploadLength: PlaceInteractor.urls.length,
        ),
      );
    }
  }

  Future<void> pickImageFromCamera() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    if (image != null) {
      PlaceInteractor.urls.add(image);
      emit(
        state.copyWith(
          imagesToUploadLength: PlaceInteractor.urls.length,
        ),
      );
    }
  }

  Future<void> pickImageFromGallery() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    if (image != null) {
      PlaceInteractor.urls.add(image);
      emit(
        state.copyWith(imagesToUploadLength: PlaceInteractor.urls.length),
      );
    }
  }

  void clearImages() {
    PlaceInteractor.urls.clear();
    emit(
      state.copyWith(imagesToUploadLength: PlaceInteractor.urls.length),
    );
  }
}
