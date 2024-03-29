import 'package:places/data/constants.dart';
import 'package:places/data/database/database.dart';
import 'package:places/data/dto/place_request.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/repository/mapper.dart';
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

  // Сохранить список отфильтрованных мест по типу
  static Future<bool> setPlacesListByType(String jsonString) async {
    final prefs = await _prefs.setString(placesListByType, jsonString);
    final placesDto = PlaceRequest.decode(jsonString);
    final places = placesDto.map<DbPlace>(Mapper.detailPlaceFromApiToUi).toSet();
    PlaceInteractor.initialFilteredPlaces.addAll(places);

    return prefs;
  }

  // Сохранить список отфильтрованных мест по дистанции
  static Future<bool> setPlacesListByDistance(String jsonString) async {
    final prefs = await _prefs.setString(placesListByDistance, jsonString);
    final placesDto = PlaceRequest.decode(jsonString);
    final places = placesDto.map<DbPlace>(Mapper.detailPlaceFromApiToUi).toSet();
    PlaceInteractor.filtersWithDistance.addAll(places);

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

  // Сохранить настройки темы
  static Future<bool> setAppTheme({required bool value}) async {
    final prefs = await _prefs.setBool(appTheme, value);

    return prefs;
  }

  // Сохранить отслеживание первого входа
  static Future<bool> setTheFirstOpen({required bool value}) async {
    final prefs = await _prefs.setBool(isFirstOpen, value);

    return prefs;
  }

  // Получить стартовую точку диапазона поиска
  static double getStartValue() {
    final prefs = _prefs.getDouble(rangeValueStart) ?? 2000.0;

    return prefs;
  }

  // Получить конечную точку диапазона поиска
  static double getEndValue() {
    final prefs = _prefs.getDouble(rangeValueEnd) ?? 8000.0;

    return prefs;
  }

  // Получить список отфильтрованных мест по типу
  static Set<DbPlace>? getPlacesListByType() {
    final jsonString = _prefs.getString(placesListByType) ?? '';
    if (jsonString.isNotEmpty) {
      final placesDto = PlaceRequest.decode(jsonString);
      final places = placesDto.map<DbPlace>(Mapper.detailPlaceFromApiToUi).toSet();

      return places;
    } else {
      // Данное решение, для того, чтобы не ловить крэш после удаления/установки приложения
      return null;
    }
  }

  // Получить список отфильтрованных мест по дистанции
  static Set<DbPlace>? getPlacesListByDistance() {
    final jsonString = _prefs.getString(placesListByDistance) ?? '';
    if (jsonString.isNotEmpty) {
      final placesDto = PlaceRequest.decode(jsonString);
      final places = placesDto.map<DbPlace>(Mapper.detailPlaceFromApiToUi).toSet();

      return places;
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

  // Получить настройки темы
  static bool getAppTheme() {
    final prefs = _prefs.getBool(appTheme) ?? false;

    return prefs;
  }

  // Получить отслеживание первого входа
  static bool getTheFirstOpen() {
    final prefs = _prefs.getBool(isFirstOpen) ?? false;

    return prefs;
  }
}
