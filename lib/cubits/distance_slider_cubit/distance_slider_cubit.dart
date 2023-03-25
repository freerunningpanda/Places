import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/store/app_preferences.dart';
import 'package:places/mocks.dart';

part 'distance_slider_state.dart';

class DistanceSliderCubit extends Cubit<DistanceSliderState> {
  double min = 100;
  double max = 10000;
  DistanceSliderCubit()
      : super(
          DistanceSliderState(
            rangeValues: RangeValues(
              AppPreferences.getStartValue(),
              AppPreferences.getEndValue(),
            ),
          ),
        );

  void changeArea({required double start, required double end}) {
    AppPreferences.setStartValue(start);
    AppPreferences.setEndValue(end);
    Mocks.rangeValues = RangeValues(start, end);
    emit(DistanceSliderState(rangeValues: Mocks.rangeValues));
  }
}
