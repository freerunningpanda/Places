import 'package:equatable/equatable.dart';

import 'package:places/data/model/place.dart';

abstract class SearchAction extends Equatable {
  @override
  List<Object?> get props => [];
}

class PlacesFoundAction extends SearchAction {
  final List<Place> filteredPlaces;

  @override
  List<Object?> get props => [filteredPlaces];

  PlacesFoundAction({
    required this.filteredPlaces,
  });
}

class PlacesEmptyAction extends SearchAction {}

// class SetQueryAction extends SearchAction {
//   final String value;
//   final TextEditingController controller;

//   @override
//   List<Object?> get props => [value];

//   SetQueryAction({
//     required this.value,
//     required this.controller,
//   });
// }

// class ClearQueryAction extends SearchAction {
//   final TextEditingController controller;

//   @override
//   List<Object?> get props => [controller];

//   ClearQueryAction({
//     required this.controller,
//   });
// }

// class SaveSearchHistoryAction extends SearchAction {
//   final String value;
//   final TextEditingController controller;

//   @override
//   List<Object?> get props => [value];

//   SaveSearchHistoryAction({
//     required this.value,
//     required this.controller,
//   });
// }

// class RemoveItemFromHistoryAction extends SearchAction {
//   final String index;

//   @override
//   List<Object?> get props => [index];

//   RemoveItemFromHistoryAction({
//     required this.index,
//   });
// }

// class RemoveAllItemsFromHistoryAction extends SearchAction {}
