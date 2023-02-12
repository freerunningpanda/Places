part of 'favorite_bloc.dart';

abstract class FavoriteState extends Equatable {
  @override
  List<Object?> get props => [];
}

class IsNotFavoriteState extends FavoriteState {}

class IsFavoriteState extends FavoriteState {}
