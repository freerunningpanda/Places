part of 'toggle_favorite_bloc.dart';

class ToggleFavoriteEvent {
  final AppDb db;
  final DbPlace place;
  final bool isFavorite;

  ToggleFavoriteEvent({
    required this.db,
    required this.place,
    required this.isFavorite,
  });
}
