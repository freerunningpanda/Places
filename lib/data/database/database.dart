import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:places/data/database/table/search_history.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [SearchHistorys],
)
class AppDb extends _$AppDb {
  @override
  int get schemaVersion => 1;

  Future<List<SearchHistory>> get allHistorysEntries => select(searchHistorys).get();

  AppDb() : super(_openConnection());

  Future<int> addHistoryItem(SearchHistorysCompanion history) {
    return into(searchHistorys).insert(history);
  }

  Future<void> deleteHistory(String text) {
    return (delete(searchHistorys)..where((tbl) => tbl.title.equals(text))).go();
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
