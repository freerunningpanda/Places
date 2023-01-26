import 'package:equatable/equatable.dart';

abstract class SearchBarState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchBarEmptyState extends SearchBarState {}

// ignore: must_be_immutable
class SearchBarHasValueState extends SearchBarState {
  String value;

  @override
  List<Object?> get props => [value];

  SearchBarHasValueState({
    required this.value,
  });
}
