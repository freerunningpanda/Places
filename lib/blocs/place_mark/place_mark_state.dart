part of 'place_mark_bloc.dart';

abstract class IPlaceMarkState extends Equatable {
  @override
  List<Object?> get props => [];

  const IPlaceMarkState();
}

class PlaceMarkInitState extends IPlaceMarkState {}

class PlaceMarkState extends IPlaceMarkState {
  final DbPlace place;
  final bool isAddPlaceBtnVisible;
  @override
  List<Object?> get props => [place, isAddPlaceBtnVisible];

  const PlaceMarkState({
    required this.place,
    required this.isAddPlaceBtnVisible,
  });
}
