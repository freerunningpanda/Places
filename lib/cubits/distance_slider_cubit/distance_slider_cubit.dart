import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/mocks.dart';

part 'distance_slider_state.dart';

class DistanceSliderCubit extends Cubit<DistanceSliderState> {
  DistanceSliderCubit() : super(const DistanceSliderState(rangeValues: RangeValues(2000, 8000)));

  void changeArea({required double start, required double end}) {
    Mocks.rangeValues = RangeValues(start, end);
    emit(DistanceSliderState(rangeValues: Mocks.rangeValues));
  }
}
