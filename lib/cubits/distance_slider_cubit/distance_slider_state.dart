part of 'distance_slider_cubit.dart';

class DistanceSliderState extends Equatable {
  final RangeValues rangeValues;

  @override
  List<Object?> get props => [rangeValues];

  const DistanceSliderState({required this.rangeValues});
}
