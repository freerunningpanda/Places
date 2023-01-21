import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class SearchAction extends Equatable {
  @override
  List<Object?> get props => [];
}

class SetQueryAction extends SearchAction {
  final String query;
  final TextEditingController controller;

  @override
  List<Object?> get props => [query];

  SetQueryAction({
    required this.query,
    required this.controller,
  });
}

class ResetQueryAction extends SearchAction {
  final TextEditingController controller;

  @override
  List<Object?> get props => [controller];

  ResetQueryAction({
    required this.controller,
  });
}
