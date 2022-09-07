import 'package:flutter/material.dart';

class AppSettings extends ChangeNotifier {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final titleFocus = FocusNode();
  final latFocus = FocusNode();
  final lotFocus = FocusNode();
  final descriptionFocus = FocusNode();

  bool isDarkMode = false;

  bool switchTheme({required bool value}) {
    notifyListeners();

    return isDarkMode = value;
  }
}
