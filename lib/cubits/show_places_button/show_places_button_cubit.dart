import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/mocks.dart';

part 'show_places_button_state.dart';

class ShowPlacesButtonCubit extends Cubit<ShowPlacesButtonState> {
  ShowPlacesButtonCubit()
      : super(
          const ShowPlacesButtonState(
            isEmpty: true,
            foundPlacesLength: 0,
          ),
        );

  void showCount({required List<Place> places}) {
    if (PlaceInteractor.filteredMocks.isEmpty) {
      PlaceInteractor.filtersWithDistance.clear();
      for (final el in places) {
        final distance = Geolocator.distanceBetween(
          Mocks.mockLat,
          Mocks.mockLot,
          el.lat,
          el.lng,
        );
        if (distance >= Mocks.rangeValues.start && distance <= Mocks.rangeValues.end) {
          PlaceInteractor.filtersWithDistance.add(el);
          debugPrint('🟡---------Добавленные места: ${PlaceInteractor.filtersWithDistance}');
          final isEmpty = PlaceInteractor.filtersWithDistance.isEmpty;
          final length = PlaceInteractor.filtersWithDistance.length;

          emit(ShowPlacesButtonState(isEmpty: isEmpty, foundPlacesLength: length));
          debugPrint('🟡---------Добавленные места. Длина: ${PlaceInteractor.filtersWithDistance.length}');
        }
      }
    } else {
      PlaceInteractor.filtersWithDistance.clear();
      for (final el in PlaceInteractor.filteredMocks) {
        final distance = Geolocator.distanceBetween(
          Mocks.mockLat,
          Mocks.mockLot,
          el.lat,
          el.lng,
        );
        if (distance >= Mocks.rangeValues.start && distance <= Mocks.rangeValues.end) {
          PlaceInteractor.filtersWithDistance.add(el);
          debugPrint('🟡---------Добавленные места: ${PlaceInteractor.filtersWithDistance}');
          final isEmpty = PlaceInteractor.filtersWithDistance.isEmpty;
          final length = PlaceInteractor.filtersWithDistance.length;
          debugPrint('🟡---------Добавленные места. Длина: ${PlaceInteractor.filtersWithDistance.length}');
          emit(ShowPlacesButtonState(isEmpty: isEmpty, foundPlacesLength: length));
        }
      }
    }
  }
}
