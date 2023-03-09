part of 'favorite_bloc.dart';

abstract class FavoriteState extends Equatable {
  @override
  List<Object?> get props => [];
  const FavoriteState();
}

class IsNotFavoriteState extends FavoriteState {
  final int placeIndex;

  @override
  List<Object?> get props => [placeIndex];

  const IsNotFavoriteState({
    required this.placeIndex,
  });
}

class IsFavoriteState extends FavoriteState {
  final int placeIndex;

  @override
  List<Object?> get props => [placeIndex];

  const IsFavoriteState({
    required this.placeIndex,
  });
}
