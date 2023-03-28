import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

@DriftDatabase(
  // relative import for the drift file. Drift also supports `package:`
  // imports
  include: {'tables.drift'},
)
class AppDb extends _$AppDb {
  @override
  int get schemaVersion => 1;

  Future<List<SearchHistory>> get allHistorysEntries => select(searchHistorys).get();

  AppDb() : super(_openConnection());

  Future<int> addHistoryItem(SearchHistorysCompanion history) {
    return into(searchHistorys).insert(history);
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
