import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'image_provider_state.dart';

class ImageProviderCubit extends Cubit<ImageProviderState> {

  final List<XFile> images = [];

  ImageProviderCubit() : super(const ImageProviderState(length: 0));

  void removeImage(int index) {
    if (images.isNotEmpty) {
      images.removeAt(index);
      emit(state.copyWith(length: images.length));
    }
  }

  Future<void> pickImageFromCamera() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    if (image != null) {
      images.add(image);
      emit(state.copyWith(length: images.length));
    }
  }

  Future<void> pickImageFromGallery() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    if (image != null) {
      images.add(image);
      emit(state.copyWith(length: images.length));
    }
  }
}
