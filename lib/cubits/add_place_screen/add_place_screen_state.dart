part of 'add_place_screen_cubit.dart';

class AddPlaceScreenState extends Equatable {
  final bool isLatActive;
  final bool isLotActive;

  @override
  List<Object?> get props => [isLatActive, isLotActive];

  const AddPlaceScreenState({
    required this.isLatActive,
    required this.isLotActive,
  });

}

