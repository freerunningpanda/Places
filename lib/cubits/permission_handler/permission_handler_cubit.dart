import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

part 'permission_handler_state.dart';

class PermissionHandlerCubit extends Cubit<PermissionHandlerState> {
  late final PermissionStatus status;
  PermissionHandlerCubit() : super(const PermissionHandlerState(status: false));

  Future<void> requestPermission() async {
    status = await Permission.location.request();

    // Если в геолокации отказано, эмитим статус с отказом и показываем все места
    if (status.isDenied) {
      emit(
        state.copyWith(status: false),
      );
      // Если статус одообрен то показываем места в радиусе гео пользователя
    } else if (status.isGranted) {
      emit(
        state.copyWith(status: true),
      );
    }
  }
}
