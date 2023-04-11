part of 'favorite_bloc.dart';

abstract class FavoriteState extends Equatable {
  @override
  List<Object?> get props => [];
  const FavoriteState();
}

class IsNotFavoriteState extends FavoriteState {
  final int placeIndex;
  final bool isFavorite;

  @override
  List<Object?> get props => [placeIndex, isFavorite];

  const IsNotFavoriteState({
    required this.placeIndex,
    required this.isFavorite,
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
