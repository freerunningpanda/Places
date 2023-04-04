import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:places/data/database/table/places.dart';
import 'package:places/data/database/table/search_history.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [SearchHistorys, DbPlaces],
)
class AppDb extends _$AppDb {
  @override
  int get schemaVersion => 2;

  Future<List<SearchHistory>> get allHistorysEntries => select(searchHistorys).get();

  Future<List<DbPlace>> get allPlacesEntries => select(dbPlaces).get();

  AppDb() : super(_openConnection());

  Future<int> addHistoryItem(SearchHistorysCompanion history) {
    return into(searchHistorys).insert(history);
  }

  Future<void> deleteHistory(int id) {
    return customStatement('DELETE FROM "search_historys" WHERE id = $id');
  }

  Future<void> deleteAllHistory() {
    return customStatement('DELETE FROM "search_historys"');
  }

  Future<int> addPlace(DbPlace place) {
    return into(dbPlaces).insert(
      DbPlacesCompanion.insert(
        lat: place.lat,
        lng: place.lng,
        name: place.name,
        urls: place.urls,
        placeType: place.placeType,
        description: place.description,
        isFavorite: place.isFavorite,
      ),
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(
    () async {
      final dbPath = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbPath.path, 'places.sqlite'));

      return NativeDatabase(file);
    },
  );
}
