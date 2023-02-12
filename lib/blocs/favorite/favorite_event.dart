part of 'favorite_bloc.dart';

class FavoriteEvent {
  final Place place;
  final bool isFavorite;

  FavoriteEvent({
    required this.place,
    required this.isFavorite,
  });
}
