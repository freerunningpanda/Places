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
  List<XFile> imagesToUpload = PlaceInteractor.urls;
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
            imagesToUpload: [],
            imagesToUploadLength: 0,
          ),
        );

  /// Добавить новое место
  Future<void> addNewPlace(PlaceModel placeModel) async {

    // Загрузить на сервер все картинки для загрузки, получив на них ссылки
    for (var i = 0; i < imagesToUpload.length; i++) {
      uploadedImages.add(await placeInteractor.uploadFile(imagesToUpload[i]));
    }

    // Полученные ссылки на загруженные картинки прокидываем в urls
    final place = PlaceModel(
      lat: placeModel.lat,
      lng: placeModel.lng,
      name: placeModel.name,
      urls: uploadedImages,
      placeType: placeModel.placeType,
      description: placeModel.description,
    );

    await placeInteractor.postPlace(place: place);

    // Очистить список с изображениями после отправки места на сервер
    clearImages();
  }

  /// Обновить состояние кнопки создания места
  void updateButtonState({required CreateButtonState createButton}) {
    emit(
      state.copyWith(
        chosenCategory: chosenCategory,
        titleValue: createButton.titleValue,
        descriptionValue: createButton.descriptionValue,
        latValue: createButton.latValue,
        lotValue: createButton.lngValue,
        imagesToUpload: imagesToUpload,
        imagesToUploadLength: imagesToUpload.length,
      ),
    );
  }

  /// Метод отвечающий за изменение состояния кнопки создания нового места
  bool buttonStyle({required CreatePlaceButtonState state}) {
    return state.chosenCategory.isEmpty ||
        state.titleValue.isEmpty ||
        state.descriptionValue.isEmpty ||
        state.latValue.isEmpty ||
        state.lotValue.isEmpty ||
        state.imagesToUpload.isEmpty;
  }

  /// Удалить картинку из списка для загрузки
  void removeImage({required int index}) {
    if (imagesToUpload.isNotEmpty) {
      imagesToUpload.removeAt(index);
      emit(
        state.copyWith(
          imagesToUploadLength: imagesToUpload.length,
        ),
      );
    }
  }

  /// Добавить картинку с камеры
  Future<void> pickImageFromCamera() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    if (image != null) {
      imagesToUpload.add(image);
      emit(
        state.copyWith(
          imagesToUploadLength: imagesToUpload.length,
        ),
      );
    }
  }

  /// Добавить картинку с галереи
  Future<void> pickImageFromGallery() async {
    final images = await ImagePicker().pickMultiImage(
      imageQuality: 50,
    );

    imagesToUpload.addAll(images);
    emit(
      state.copyWith(imagesToUploadLength: imagesToUpload.length),
    );
  }

  /// Очистить картинки (для загрузки, загруженные)
  void clearImages() {
    imagesToUpload.clear();
    uploadedImages.clear();
    emit(
      state.copyWith(imagesToUploadLength: imagesToUpload.length),
    );
  }
}
