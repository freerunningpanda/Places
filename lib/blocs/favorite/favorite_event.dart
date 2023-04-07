part of 'favorite_bloc.dart';

class FavoriteEvent {
  // final AppDb db;
  final DbPlace place;
  final bool isFavorite;
  final int placeIndex;

  FavoriteEvent({
    // required this.db,
    required this.place,
    required this.isFavorite,
    required this.placeIndex,
  });
}
