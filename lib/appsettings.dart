import 'package:flutter/cupertino.dart';

class AppSettings extends ChangeNotifier {
  bool isDarkMode = false;

  bool switchTheme({required bool value}) {
    notifyListeners();

    return isDarkMode = value;
  }
}
