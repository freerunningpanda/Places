import 'package:places/data/constants.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/store/store.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences extends Store {
  static late SharedPreferences _prefs;

  static Future<SharedPreferences> init() async => _prefs = await SharedPreferences.getInstance().then(
        (prefs) => _prefs = prefs,
      );

  // Сохранить стартовую точку диапазона поиска
  static Future<bool> setStartValue(double start) async {
    final prefs = await _prefs.setDouble(rangeValueStart, start);

    return prefs;
  }

  // Сохранить конечную точку диапазона поиска
  static Future<bool> setEndValue(double end) async {
    final prefs = await _prefs.setDouble(rangeValueEnd, end);

    return prefs;
  }

  // Сохранить список отфильтрованных мест
  static Future<bool> setPlacesList(String jsonString) async {
    final prefs = await _prefs.setString(placesList, jsonString);

    return prefs;
  }

  // Сохранить фильтр по имени
  static Future<bool> setCategoryByName({required String title, required bool isEnabled}) async {
    final prefs = await _prefs.setBool(title, isEnabled);

    return prefs;
  }

  // Сохранить фильтр по статусу: включен/отключён
  static Future<bool> setCategoryByStatus({required String type, required bool isEnabled}) async {

    final prefs = await _prefs.setBool(type, isEnabled);

    return prefs;
  }

  // Получить стартовую точку диапазона поиска
  static double getStartValue() {
    final prefs = _prefs.getDouble(rangeValueStart) ?? 100.0;

    return prefs;
  }

  // Получить конечную точку диапазона поиска
  static double getEndValue() {
    final prefs = _prefs.getDouble(rangeValueEnd) ?? 10000.0;

    return prefs;
  }

  // Получить список отфильтрованных мест
  static Set<Place>? getPlacesList() {
    final jsonString = _prefs.getString(placesList) ?? '';
    if (jsonString.isNotEmpty) {
      final places = Place.decode(jsonString);

      return places;
    } else {
      // Данное решение, для того, чтобы не ловить крэш после удаления/установки приложения
      return null;
    }
  }

  // Получить длину списка отфильтрованных мест
  static int? getPlacesListLength() {
    final jsonString = _prefs.getString(placesList) ?? '';
    if (jsonString.isNotEmpty) {
      final places = Place.decode(jsonString);

      return places.length;
    } else {
      // Данное решение, для того, чтобы не ловить крэш после удаления/установки приложения
      return null;
    }
  }

  // Получить значение (пустой/не пустой) списка отфильтрованных мест
  static bool? checkListValue() {
    final jsonString = _prefs.getString(placesList) ?? '';
    if (jsonString.isNotEmpty) {
      final places = Place.decode(jsonString);

      return places.isEmpty;
    } else {
      // Данное решение, для того, чтобы не ловить крэш после удаления/установки приложения
      return null;
    }
  }

  // Получить фильтр по имени
  static bool getCategoryByName(String title) {
    final prefs = _prefs.getBool(title) ?? false;

    return prefs;
  }

  // Получить фильтр по статусу: включен/отключён
  static bool getCategoryByStatus(String type) {
    final prefs = _prefs.getBool(type) ?? false;

    return prefs;
  }
}
