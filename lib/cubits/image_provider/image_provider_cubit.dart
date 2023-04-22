import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:places/data/interactor/place_interactor.dart';

part 'image_provider_state.dart';

class ImageProviderCubit extends Cubit<ImageProviderState> {


  ImageProviderCubit() : super(const ImageProviderState(length: 0));

  void removeImage(int index) {
    if (PlaceInteractor.urls.isNotEmpty) {
      PlaceInteractor.urls.removeAt(index);
      emit(state.copyWith(length: PlaceInteractor.urls.length));
    }
  }

  Future<void> pickImageFromCamera() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    if (image != null) {
      PlaceInteractor.urls.add(image);
      emit(state.copyWith(length: PlaceInteractor.urls.length));
    }
  }

  Future<void> pickImageFromGallery() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    if (image != null) {
      PlaceInteractor.urls.add(image);
      emit(state.copyWith(length: PlaceInteractor.urls.length));
    }
  }
}
