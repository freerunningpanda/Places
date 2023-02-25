part of 'add_sight_screen_cubit.dart';

class AddSightScreenState extends Equatable {
  final bool isLatActive;
  final bool isLotActive;

  @override
  List<Object?> get props => [isLatActive, isLotActive];

  const AddSightScreenState({
    required this.isLatActive,
    required this.isLotActive,
  });

}

