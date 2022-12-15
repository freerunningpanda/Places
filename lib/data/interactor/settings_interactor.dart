import 'package:flutter/cupertino.dart';

class SettingsInteractor extends ChangeNotifier {
  bool isDarkMode = false;
  
  bool switchTheme({required bool value}) {
    notifyListeners();

    return isDarkMode = value;
  }
}
