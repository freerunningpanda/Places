part of 'favorite_bloc.dart';

abstract class FavoriteEvent {}

class AddToFavoriteEvent extends FavoriteEvent {
  final AppDb db;
  final DbPlace place;
  final int placeIndex;
  bool isFavorite;

  AddToFavoriteEvent({
    required this.db,
    required this.place,
    required this.isFavorite,
    required this.placeIndex,
  });
}

class RemoveFromFavoriteEvent extends FavoriteEvent {
  final AppDb db;
  final DbPlace place;
  final int placeIndex;
  bool isFavorite;

  RemoveFromFavoriteEvent({
    required this.db,
    required this.place,
    required this.isFavorite,
    required this.placeIndex,
  });
}
