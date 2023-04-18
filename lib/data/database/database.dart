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

  /// Получить историю поисковых запросов
  Future<List<SearchHistory>> get allHistorysEntries => select(searchHistorys).get();

  /// Получить все места не хранящиеся в Избранном
  Future<List<DbPlace>> get allPlacesEntries => (select(dbPlaces)..where((tbl) => tbl.isFavorite.equals(false))).get();

  /// Получить список избранных мест
  Future<List<DbPlace>> get favoritePlacesEntries =>
      (select(dbPlaces)..where((tbl) => tbl.isFavorite.equals(true))).get();

  /// Получить список мест отмеченных как для экрана поиска
  // Future<List<DbPlace>> get searchedPlacesEntries =>
  //     (select(dbPlaces)..where((tbl) => tbl.isSearchScreen.equals(true))).get();

  
  AppDb() : super(_openConnection());

  
  /// Сохранить запрос в истории поиска
  Future<int> addHistoryItem(SearchHistorysCompanion history) {
    return into(searchHistorys).insert(history);
  }

  /// Удалить элемент истории поиска
  Future<void> deleteHistory(int id) {
    return customStatement('DELETE FROM "search_historys" WHERE id = $id');
  }

  /// Очистить всю историю поиска
  Future<void> deleteAllHistory() {
    return customStatement('DELETE FROM "search_historys"');
  }

  /// Пометить место как "Избранное"
  Future<int> addPlaceToFavorites(DbPlace place, {required bool isSearchScreen}) async {
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
        isSearchScreen: isSearchScreen,
      ),
    );
  }

  /// Удалить только те места, которые не хранятся в избранном
  Future<void> deleteAllPlaces() async {
    await customStatement(
      'DELETE FROM "db_places" WHERE is_favorite = false',
    ); // Сначала удалить предыдущие места из таблицы
  }

  /// Удалить места помеченные как для поиска
  // Future<void> deleteUnsearchedPlaces() => (delete(dbPlaces)..where((tbl) => tbl.isSearchScreen.equals(true))).go();

  /// Удалить дубликаты мест по имени (на всякий случай)
  Future<void> distinctByName() async {
    await customUpdate('''
      DELETE FROM db_places
      WHERE id NOT IN (
        SELECT MIN(id)
        FROM db_places
        GROUP BY name
      )
    ''');
  }

  /// Сохранить список отфильтрованных мест для экрана поиска
  Future<void> addPlacesToSearchScreen(List<DbPlace> places, {required bool isSearchScreen}) async {
    final distinctPlaces = places.toSet().toList();

    for (final place in distinctPlaces) {
      await into(dbPlaces).insert(
        DbPlacesCompanion.insert(
          id: place.id,
          lat: place.lat,
          lng: place.lng,
          name: place.name,
          urls: place.urls,
          placeType: place.placeType,
          description: place.description,
          isFavorite: false,
          isSearchScreen: isSearchScreen,
        ),
      );
    }
    // удалить дубликаты мест по имени
    await distinctByName();
  }

  /// Обновить место в базе
  Future<void> updatePlace(DbPlace updatedPlace) async {
    await update(dbPlaces).replace(updatedPlace);
  }

  /// Удалить место из базы
  Future<void> deletePlace(DbPlace place) async {
    await (delete(dbPlaces)..where((tbl) => tbl.id.equals(place.id))).go();
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
