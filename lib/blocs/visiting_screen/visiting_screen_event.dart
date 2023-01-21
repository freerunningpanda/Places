import 'package:equatable/equatable.dart';

abstract class VisitingScreenEvent extends Equatable {
  @override
  List<Object?> get props => [];

  const VisitingScreenEvent();
}

// Пустой список мест
class VisitingScreenLoad extends VisitingScreenEvent {}
