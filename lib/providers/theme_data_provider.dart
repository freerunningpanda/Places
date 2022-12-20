import 'package:flutter/material.dart';

class ThemeDataProvider extends ChangeNotifier {
  bool isDarkMode = false;
  
  bool switchTheme({required bool value}) {
    notifyListeners();

    return isDarkMode = value;
  }
}