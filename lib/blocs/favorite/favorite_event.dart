part of 'favorite_bloc.dart';

class FavoriteEvent {
  final DbPlace place;
  final bool isFavorite;
  final int placeIndex;

  FavoriteEvent({
    required this.place,
    required this.isFavorite,
    required this.placeIndex,
  });
}
