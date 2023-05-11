part of 'create_place_button_cubit.dart';

class CreatePlaceButtonState extends Equatable {
  final List<Category> chosenCategory;
  final String titleValue;
  final String descriptionValue;
  final String latValue;
  final String lotValue;
  final List<XFile> imagesToUpload;
  final int imagesToUploadLength;

  @override
  List<Object?> get props => [
        chosenCategory,
        titleValue,
        descriptionValue,
        latValue,
        lotValue,
        imagesToUpload,
        imagesToUploadLength,
      ];

  const CreatePlaceButtonState({
    required this.chosenCategory,
    required this.titleValue,
    required this.descriptionValue,
    required this.latValue,
    required this.lotValue,
    required this.imagesToUpload,
    required this.imagesToUploadLength,
  });

  CreatePlaceButtonState copyWith({
    List<Category>? chosenCategory,
    String? titleValue,
    String? descriptionValue,
    String? latValue,
    String? lotValue,
    List<XFile>? imagesToUpload,
    int? imagesToUploadLength,
  }) {
    return CreatePlaceButtonState(
      chosenCategory: chosenCategory ?? this.chosenCategory,
      titleValue: titleValue ?? this.titleValue,
      descriptionValue: descriptionValue ?? this.descriptionValue,
      latValue: latValue ?? this.latValue,
      lotValue: lotValue ?? this.lotValue,
      imagesToUpload: imagesToUpload ?? this.imagesToUpload,
      imagesToUploadLength: imagesToUploadLength ?? this.imagesToUploadLength,
    );
  }
}
