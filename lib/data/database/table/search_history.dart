import 'package:drift/drift.dart';

class SearchHistorys extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 16)();
}
