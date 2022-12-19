import 'package:flutter/material.dart';

class DarkModeProvider extends ChangeNotifier {
  bool isDarkMode = false;
  
  bool switchTheme({required bool value}) {
    notifyListeners();

    return isDarkMode = value;
  }
}