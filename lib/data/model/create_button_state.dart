import 'package:image_picker/image_picker.dart';
import 'package:places/data/model/category.dart';

class CreateButtonState {
  final String titleValue;
  final List<Category> chosenCategory;
  final String descriptionValue;
  final String latValue;
  final String lngValue;
  final List<XFile> imagesToUpload;

  CreateButtonState({
    required this.titleValue,
    required this.chosenCategory,
    required this.descriptionValue,
    required this.latValue,
    required this.lngValue,
    required this.imagesToUpload,
  });
}
