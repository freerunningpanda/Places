import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_sight_screen_state.dart';

class AddSightScreenCubit extends Cubit<AddSightScreenState> {
  bool isLat = false;
  bool isLot = false;

  AddSightScreenCubit()
      : super(
          const AddSightScreenState(
            isLatActive: false,
            isLotActive: false,
          ),
        );

  void tapOnLat() {
    isLat = true;
    isLot = false;
    emit(
      AddSightScreenState(
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
      AddSightScreenState(
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
      AddSightScreenState(
        isLatActive: isLat,
        isLotActive: isLat,
      ),
    );
  }

  void tapOnLot() {
    isLat = false;
    isLot = true;
    emit(
      AddSightScreenState(
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
      AddSightScreenState(
        isLatActive: isLat,
        isLotActive: isLat,
      ),
    );
  }
}
