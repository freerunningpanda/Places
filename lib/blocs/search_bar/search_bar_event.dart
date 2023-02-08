part of 'search_bar_bloc.dart';

class SearchBarEvent extends Equatable {
  final String value;

  @override
  List<Object?> get props => [value];

  const SearchBarEvent({
    required this.value,
  });
}
