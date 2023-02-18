part of 'details_screen_bloc.dart';

abstract class DetailsScreenState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DetailsScreenLoadingState extends DetailsScreenState {}

class DetailsScreenLoadedState extends DetailsScreenState {
  final Place place;

  @override
  List<Object?> get props => [place];

  DetailsScreenLoadedState({
    required this.place,
  });
}
