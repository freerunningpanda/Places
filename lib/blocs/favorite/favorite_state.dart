part of 'favorite_bloc.dart';

abstract class FavoriteState extends Equatable {
  @override
  List<Object?> get props => [];
}

class IsNotFavoriteState extends FavoriteState {
  final bool isFavorite;

  @override
  List<Object?> get props => [isFavorite];

  IsNotFavoriteState({
    required this.isFavorite,
  });
}

class IsFavoriteState extends FavoriteState {
  final bool isFavorite;

  @override
  List<Object?> get props => [isFavorite];

  IsFavoriteState({
    required this.isFavorite,
  });
}
