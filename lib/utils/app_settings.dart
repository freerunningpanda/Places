import 'package:flutter/cupertino.dart';

class AppSettings extends ChangeNotifier {
  bool isDarkMode = false;

  bool switchToDarkMode({required bool value}) {
    isDarkMode = value;
    notifyListeners();
    
    return isDarkMode;
  }
}
