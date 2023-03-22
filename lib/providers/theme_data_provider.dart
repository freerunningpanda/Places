import 'package:flutter/material.dart';
import 'package:places/data/store/app_preferences.dart';

class ThemeDataProvider extends ChangeNotifier {
  bool isDarkMode = AppPreferences.getAppTheme();
  
  bool switchTheme({required bool value}) {
    notifyListeners();

    return isDarkMode = value;
  }
}