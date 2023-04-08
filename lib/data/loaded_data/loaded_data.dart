import 'package:flutter/foundation.dart';
import 'package:places/data/database/database.dart';

class LoadedData {
  static List<DbPlace> list = [];

  static Future<void> loadFilteredPlaces(AppDb db) async {
    list = await db.allPlacesEntries;
    debugPrint('list_of_founded_places: ${list.length}');
  }
}
