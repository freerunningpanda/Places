// import 'package:flutter/foundation.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Prefs {
//   late SharedPreferences prefs;

//   Future<void> init() async {
//     prefs = await SharedPreferences.getInstance().then((value) => value = prefs);
//   }

//   Future<void> setFavoriteState({required bool value, required String key}) async {
//     debugPrint('Setted: $value Key: $key');
//     await prefs.setBool(key, value);
//     loadFavoriteState(key: key);
//   }

//   Future<void> removeFromPrefs({required String key}) async {
//     debugPrint('Removed by key: $key');
//     await prefs.remove(key);
//     loadFavoriteState(key: key);
//   }

//   void loadFavoriteState({required String key}) {
//     debugPrint('Loaded by key: $key');
//     prefs.getBool(key);
//   }
// }
