part of 'create_place_button_cubit.dart';

class CreatePlaceButtonState extends Equatable {
  final List<Category> chosenCategory;
  final String titleValue;
  final String descriptionValue;
  final String latValue;
  final String lotValue;

  @override
  List<Object?> get props => [
        chosenCategory,
        titleValue,
        descriptionValue,
        latValue,
        lotValue,
      ];

  const CreatePlaceButtonState({
    required this.chosenCategory,
    required this.titleValue,
    required this.descriptionValue,
    required this.latValue,
    required this.lotValue,
  });
}
