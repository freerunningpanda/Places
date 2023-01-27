import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';

// WM для AddSightScreen
class AddSightScreenWidgetModel extends WidgetModel {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final searchController = TextEditingController();
  final latController = TextEditingController();
  final lotController = TextEditingController();
  final titleFocus = FocusNode();
  final searchFocus = FocusNode();
  final descriptionFocus = FocusNode();
  final latFocus = FocusNode();
  final lotFocus = FocusNode();
  bool isLat = false;
  // ignore: avoid_unused_constructor_parameters
  AddSightScreenWidgetModel(WidgetModelDependencies baseDependencies) : super(baseDependencies);

  void tapOnLat() {
    isLat = true;
  }

  void goToLat() {
    isLat = true;
    latFocus.requestFocus();
  }

  void goToLot() {
    isLat = false;
    lotFocus.requestFocus();
  }

  void tapOnLot() {
    isLat = false;
  }

  void goToDescription() {
    isLat = false;
    descriptionFocus.requestFocus();
  }
}

WidgetModel buildAddSightScreenWM(BuildContext context) => AddSightScreenWidgetModel(
      const WidgetModelDependencies(),
    );
