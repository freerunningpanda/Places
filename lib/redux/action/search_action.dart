import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:places/data/model/place.dart';

abstract class SearchAction extends Equatable {
  @override
  List<Object?> get props => [];
}

class EmptyPlacesAction extends SearchAction {}

class FoundedPlacesAction extends SearchAction {
  final List<Place> filteredPlaces;

  @override
  List<Object?> get props => [filteredPlaces];

  FoundedPlacesAction({
    required this.filteredPlaces,
  });
}

class SetQueryAction extends SearchAction {
  final String value;
  final List<Place> filteredPlaces;
  final TextEditingController controller;

  @override
  List<Object?> get props => [value];

  SetQueryAction({
    required this.value,
    required this.controller,
    required this.filteredPlaces,
  });
}

class ClearQueryAction extends SearchAction {
  final TextEditingController controller;

  @override
  List<Object?> get props => [controller];

  ClearQueryAction({
    required this.controller,
  });
}

class SaveSearchHistoryAction extends SearchAction {
  final String value;
  final TextEditingController controller;

  @override
  List<Object?> get props => [value];

  SaveSearchHistoryAction({
    required this.value,
    required this.controller,
  });
}

class RemoveItemFromHistoryAction extends SearchAction {
  final String index;

  @override
  List<Object?> get props => [index];

  RemoveItemFromHistoryAction({
    required this.index,
  });
}

class RemoveAllItemsFromHistoryAction extends SearchAction {}
