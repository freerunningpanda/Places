part of 'create_place_button_cubit.dart';

class CreatePlaceButtonState extends Equatable {
  final List<Category>? chosenCategory;

  @override
  List<Object?> get props => [chosenCategory];

  const CreatePlaceButtonState({
    this.chosenCategory,
  });
}
