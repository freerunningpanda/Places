part of 'search_bar_bloc.dart';

abstract class SearchBarState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchBarEmptyState extends SearchBarState {}

class SearchBarHasValueState extends SearchBarState {
  final String value;

  @override
  List<Object?> get props => [value];

  SearchBarHasValueState({
    required this.value,
  });
}
