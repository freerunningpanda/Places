// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// DriftDatabaseGenerator
// **************************************************************************

// ignore_for_file: type=lint
class SearchHistory extends DataClass implements Insertable<SearchHistory> {
  final int id;
  final String? placeId;
  const SearchHistory({required this.id, this.placeId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || placeId != null) {
      map['placeId'] = Variable<String>(placeId);
    }
    return map;
  }

  SearchHistorysCompanion toCompanion(bool nullToAbsent) {
    return SearchHistorysCompanion(
      id: Value(id),
      placeId: placeId == null && nullToAbsent
          ? const Value.absent()
          : Value(placeId),
    );
  }

  factory SearchHistory.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SearchHistory(
      id: serializer.fromJson<int>(json['id']),
      placeId: serializer.fromJson<String?>(json['placeId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'placeId': serializer.toJson<String?>(placeId),
    };
  }

  SearchHistory copyWith(
          {int? id, Value<String?> placeId = const Value.absent()}) =>
      SearchHistory(
        id: id ?? this.id,
        placeId: placeId.present ? placeId.value : this.placeId,
      );
  @override
  String toString() {
    return (StringBuffer('SearchHistory(')
          ..write('id: $id, ')
          ..write('placeId: $placeId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, placeId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SearchHistory &&
          other.id == this.id &&
          other.placeId == this.placeId);
}

class SearchHistorysCompanion extends UpdateCompanion<SearchHistory> {
  final Value<int> id;
  final Value<String?> placeId;
  const SearchHistorysCompanion({
    this.id = const Value.absent(),
    this.placeId = const Value.absent(),
  });
  SearchHistorysCompanion.insert({
    this.id = const Value.absent(),
    this.placeId = const Value.absent(),
  });
  static Insertable<SearchHistory> custom({
    Expression<int>? id,
    Expression<String>? placeId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (placeId != null) 'placeId': placeId,
    });
  }

  SearchHistorysCompanion copyWith({Value<int>? id, Value<String?>? placeId}) {
    return SearchHistorysCompanion(
      id: id ?? this.id,
      placeId: placeId ?? this.placeId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (placeId.present) {
      map['placeId'] = Variable<String>(placeId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SearchHistorysCompanion(')
          ..write('id: $id, ')
          ..write('placeId: $placeId')
          ..write(')'))
        .toString();
  }
}

class SearchHistorys extends Table
    with TableInfo<SearchHistorys, SearchHistory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  SearchHistorys(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _placeIdMeta = const VerificationMeta('placeId');
  late final GeneratedColumn<String> placeId = GeneratedColumn<String>(
      'placeId', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [id, placeId];
  @override
  String get aliasedName => _alias ?? 'searchHistorys';
  @override
  String get actualTableName => 'searchHistorys';
  @override
  VerificationContext validateIntegrity(Insertable<SearchHistory> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('placeId')) {
      context.handle(_placeIdMeta,
          placeId.isAcceptableOrUnknown(data['placeId']!, _placeIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SearchHistory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SearchHistory(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      placeId: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}placeId']),
    );
  }

  @override
  SearchHistorys createAlias(String alias) {
    return SearchHistorys(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

abstract class _$AppDb extends GeneratedDatabase {
  _$AppDb(QueryExecutor e) : super(e);
  late final SearchHistorys searchHistorys = SearchHistorys(this);
  Selectable<SearchHistory> searchItem() {
    return customSelect('SELECT * FROM searchHistorys',
        variables: [],
        readsFrom: {
          searchHistorys,
        }).asyncMap(searchHistorys.mapFromRow);
  }

  @override
  Iterable<TableInfo<Table, dynamic>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [searchHistorys];
}
