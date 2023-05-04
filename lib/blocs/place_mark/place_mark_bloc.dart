import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/database/database.dart';

part 'place_mark_event.dart';
part 'place_mark_state.dart';

class PlaceMarkBloc extends Bloc<PlaceMarkEvent, IPlaceMarkState>  {
  bool isAddPlaceBtnVisible = false;
  DbPlace? tappedPlacemark;

  PlaceMarkBloc() : super(PlaceMarkInitState()) {
    on<PlaceMarkEvent>(
      (event, emit) {
        tapOnPlacemark(event.place);
        emit(
          PlaceMarkState(
            place: event.place,
            isAddPlaceBtnVisible: isAddPlaceBtnVisible,
          ),
        );
      },
    );
  }

  void tapOnPlacemark(DbPlace place) {
    if (tappedPlacemark != place) {
      isAddPlaceBtnVisible = false;
      tappedPlacemark = place;
    } else {
      isAddPlaceBtnVisible = true;
      tappedPlacemark = null;
    }
  }
}
