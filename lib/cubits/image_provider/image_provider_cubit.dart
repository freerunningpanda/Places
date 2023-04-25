import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:places/data/interactor/place_interactor.dart';

part 'image_provider_state.dart';

class ImageProviderCubit extends Cubit<ImageProviderState> {
  ImageProviderCubit() : super(const ImageProviderState(length: 0));


}
