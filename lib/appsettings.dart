import 'package:flutter/material.dart';

class AppSettings extends ChangeNotifier {
  final latFocus = FocusNode();
  final lotFocus = FocusNode();

  bool isDarkMode = false;

  bool switchTheme({required bool value}) {
    notifyListeners();

    return isDarkMode = value;
  }
}
