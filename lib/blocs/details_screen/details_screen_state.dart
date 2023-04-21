part of 'details_screen_bloc.dart';

abstract class DetailsScreenState extends Equatable {
  @override
  List<Object?> get props => [];

  const DetailsScreenState();
}

class DetailsScreenLoadingState extends DetailsScreenState {}

class DetailsScreenLoadedState extends DetailsScreenState {
  final DbPlace place;

  @override
  List<Object?> get props => [place];

  const DetailsScreenLoadedState({
    required this.place,
  });
}
