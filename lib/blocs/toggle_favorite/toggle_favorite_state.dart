part of 'toggle_favorite_bloc.dart';

abstract class IToggleFavoriteState extends Equatable {
  @override
  List<Object> get props => [];

  const IToggleFavoriteState();
}

class ToggleFavoriteInitial extends IToggleFavoriteState {}

class ToggleFavoriteState extends IToggleFavoriteState {
  final AppDb db;
  final DbPlace place;
  final bool isFavorite;

  @override
  List<Object> get props => [db, place, isFavorite];

  const ToggleFavoriteState({
    required this.db,
    required this.place,
    required this.isFavorite,
  });
}
