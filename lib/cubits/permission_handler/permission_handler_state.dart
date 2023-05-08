part of 'permission_handler_cubit.dart';

class PermissionHandlerState extends Equatable {
  final bool status;

  @override
  List<Object?> get props => [status];

  const PermissionHandlerState({required this.status});

  PermissionHandlerState copyWith({
    bool? status,
  }) {
    return PermissionHandlerState(
      status: status ?? this.status,
    );
  }
}
