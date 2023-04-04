import 'package:drift/drift.dart';

class DbPlaces extends Table {
  IntColumn get id => integer().autoIncrement()();
  RealColumn get lat => real()();
  RealColumn get lng => real()();
  TextColumn get name => text().withLength(min: 1, max: 255)();
  TextColumn get urls => text()();
  TextColumn get placeType => text().withLength(min: 1, max: 255)();
  TextColumn get description => text()();
  BoolColumn get isFavorite => boolean()();
}
