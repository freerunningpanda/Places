part of 'show_places_button_cubit.dart';

class ShowPlacesButtonState extends Equatable {
  final bool isEmpty;
  final int foundPlacesLength;

  @override
  List<Object?> get props => [isEmpty, foundPlacesLength];

  const ShowPlacesButtonState({
    required this.isEmpty,
    required this.foundPlacesLength,
  });
}
