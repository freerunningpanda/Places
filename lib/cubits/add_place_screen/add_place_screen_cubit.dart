import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/repository/category_repository.dart';

part 'add_place_screen_state.dart';

class AddPlaceScreenCubit extends Cubit<AddPlaceScreenState> {
  final categories = CategoryRepository.categories;
  final chosenCategories = CategoryRepository.chosenCategories;
  bool isLat = false;
  bool isLot = false;

  AddPlaceScreenCubit()
      : super(
          const AddPlaceScreenState(
            isLatActive: false,
            isLotActive: false,
          ),
        );

  void tapOnLat() {
    isLat = true;
    isLot = false;
    emit(
      AddPlaceScreenState(
        isLatActive: isLat,
        isLotActive: isLat,
      ),
    );
  }

  void goToLat({required FocusNode latFocus}) {
    isLat = true;
    isLot = false;
    latFocus.requestFocus();
    emit(
      AddPlaceScreenState(
        isLatActive: isLat,
        isLotActive: isLat,
      ),
    );
  }

  void goToLot({required FocusNode lotFocus}) {
    isLat = false;
    isLot = true;
    lotFocus.requestFocus();
    emit(
      AddPlaceScreenState(
        isLatActive: isLat,
        isLotActive: isLat,
      ),
    );
  }

  void tapOnLot() {
    isLat = false;
    isLot = true;
    emit(
      AddPlaceScreenState(
        isLatActive: isLat,
        isLotActive: isLot,
      ),
    );
  }

  void goToDescription({required FocusNode descriptionFocus}) {
    isLat = false;
    isLot = false;
    descriptionFocus.requestFocus();
    emit(
      AddPlaceScreenState(
        isLatActive: isLat,
        isLotActive: isLat,
      ),
    );
  }
}
