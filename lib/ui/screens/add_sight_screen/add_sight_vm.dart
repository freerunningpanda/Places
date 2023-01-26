import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';

// WM для AddSightScreen
class AddSightScreenWidgetModel extends WidgetModel {
  // ignore: avoid_unused_constructor_parameters
  AddSightScreenWidgetModel(WidgetModelDependencies baseDependencies, BuildContext context) : super(baseDependencies);
}

WidgetModel buildAddSightScreenWM(BuildContext context) => AddSightScreenWidgetModel(
      const WidgetModelDependencies(),
      context,
    );