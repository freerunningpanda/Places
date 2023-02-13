part of 'favorite_bloc.dart';

abstract class FavoriteState extends Equatable {
  @override
  List<Object?> get props => [];
}

class IsNotFavoriteState extends FavoriteState {
  final int placeIndex;

  @override
  List<Object?> get props => [placeIndex];

  IsNotFavoriteState({
    required this.placeIndex,
  });
}

class IsFavoriteState extends FavoriteState {
  final int placeIndex;

  @override
  List<Object?> get props => [placeIndex];

  IsFavoriteState({
    required this.placeIndex,
  });
}
