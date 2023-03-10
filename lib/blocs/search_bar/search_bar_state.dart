part of 'search_bar_bloc.dart';

abstract class SearchBarState extends Equatable {
  @override
  List<Object?> get props => [];

  const SearchBarState();
}

class SearchBarEmptyState extends SearchBarState {}

class SearchBarHasValueState extends SearchBarState {
  final String value;

  @override
  List<Object?> get props => [value];

  const SearchBarHasValueState({
    required this.value,
  });
}
