import 'package:places/data/constants.dart';
import 'package:places/data/store/store.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences extends Store {
  static late SharedPreferences _prefs;

  static Future init() async => _prefs = await SharedPreferences.getInstance().then(
        (prefs) => _prefs = prefs,
      );

  static Future setStartValue(double start) async => _prefs.setDouble(rangeValueStart, start);
  static Future setEndValue(double end) async => _prefs.setDouble(rangeValueEnd, end);

  static double getStartValue() => _prefs.getDouble(rangeValueStart) ?? 100.0;
  static double getEndValue() => _prefs.getDouble(rangeValueEnd) ?? 10000.0;
}
