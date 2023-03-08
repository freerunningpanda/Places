import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/model/place.dart';
import 'package:places/ui/res/app_strings.dart';

part 'image_provider_state.dart';

class ImageProviderCubit extends Cubit<ImageProviderState> {
  static final List<Place> places = [];

  static List<Place> pickedImage = [
    Place(
      id: 27,
      name: 'Мытищинский парк',
      lat: 55.911397,
      lng: 37.740033,
      urls: ['https://pic.rutubelist.ru/video/39/09/390905576c021a02b5b57c374ba16621.jpg'],
      description: 'Мытищинский парк — центральный парк в одноименном городе Московской области.',
      placeType: AppString.park,
    ),
  ];
  ImageProviderCubit() : super(const ImageProviderState());

  void pickImage() {
    if (ImageProviderCubit.places.isEmpty) {
      ImageProviderCubit.places.addAll(ImageProviderCubit.pickedImage);
      emit(state);
    }
  }

  void removeImage(int index) {
    if (ImageProviderCubit.places.isNotEmpty) {
      ImageProviderCubit.places.removeAt(index);
      emit(state);
    }
  }
}
