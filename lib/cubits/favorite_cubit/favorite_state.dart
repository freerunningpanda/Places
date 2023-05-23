part of 'favorite_cubit.dart';

class FavoriteState extends Equatable {
  final bool isFavorite;

  @override
  List<Object?> get props => [isFavorite];

  const FavoriteState({
    required this.isFavorite,
  });

  FavoriteState copyWith({
    bool? isFavorite,
  }) {
    return FavoriteState(
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
