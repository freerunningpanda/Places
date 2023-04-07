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

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
        onUpgrade: (m, from, to) async {
          if (from == 1) {
            await m.drop(dbPlaces);
            await m.createTable(dbPlaces);
          }
        },
      );

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

  Future<int> addPlace(DbPlace place) async {
    return into(dbPlaces).insert(
      DbPlacesCompanion.insert(
        id: place.id,
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

  Future<void> addPlaces(List<DbPlace> places) async {
    await customStatement('DELETE FROM "db_places"'); // Сначала удалить предыдущие места из таблицы
    await batch((batch) {
      for (final place in places) {
        batch.insert(
          dbPlaces,
          DbPlacesCompanion.insert(
            id: place.id,
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
    });
  }

  // Future<int> addPlace(DbPlace place) async {
  //   final existingPlace = await (select(dbPlaces)..where((tbl) => tbl.name.equals(place.name))).getSingleOrNull();

  //   if (existingPlace != null) {
  //     await update(dbPlaces).replace(place.copyWith(id: existingPlace.id));

  //     return existingPlace.id;
  //   } else {
  //     return into(dbPlaces).insert(
  //       DbPlacesCompanion.insert(
  //         lat: place.lat,
  //         lng: place.lng,
  //         name: place.name,
  //         urls: place.urls,
  //         placeType: place.placeType,
  //         description: place.description,
  //         isFavorite: place.isFavorite,
  //       ),
  //     );
  //   }
  // }

  Future<void> deletePlace(String name) {
    // return transaction(
    //   () async {
    //     await (update(dbPlaces)..where((tbl) => tbl.name.equals(name))).write(
    //       const DbPlacesCompanion(
    //         isFavorite: Value(false),
    //       ),
    //     );
    //     await (delete(dbPlaces)..where((tbl) => tbl.name.equals(name))).go();
    //   },
    // );
    //  return (delete(dbPlaces)..where((tbl) => tbl.name.equals(name))).go();
    return transaction(
      () async {
        await (update(dbPlaces)..where((tbl) => tbl.name.equals(name)))
            .write(
              const DbPlacesCompanion(
                isFavorite: Value(false),
              ),
            )
            .then(
              (value) => (delete(dbPlaces)..where((tbl) => tbl.name.equals(name))).go(),
            );
        // await (delete(dbPlaces)..where((tbl) => tbl.name.equals(name))).go();
      },
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
