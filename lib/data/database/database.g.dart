// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// DriftDatabaseGenerator
// **************************************************************************

// ignore_for_file: type=lint
class SearchHistory extends DataClass implements Insertable<SearchHistory> {
  final int id;
  final String? searchItemId;
  const SearchHistory({required this.id, this.searchItemId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || searchItemId != null) {
      map['searchItemId'] = Variable<String>(searchItemId);
    }
    return map;
  }

  SearchHistorysCompanion toCompanion(bool nullToAbsent) {
    return SearchHistorysCompanion(
      id: Value(id),
      searchItemId: searchItemId == null && nullToAbsent
          ? const Value.absent()
          : Value(searchItemId),
    );
  }

  factory SearchHistory.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SearchHistory(
      id: serializer.fromJson<int>(json['id']),
      searchItemId: serializer.fromJson<String?>(json['searchItemId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'searchItemId': serializer.toJson<String?>(searchItemId),
    };
  }

  SearchHistory copyWith(
          {int? id, Value<String?> searchItemId = const Value.absent()}) =>
      SearchHistory(
        id: id ?? this.id,
        searchItemId:
            searchItemId.present ? searchItemId.value : this.searchItemId,
      );
  @override
  String toString() {
    return (StringBuffer('SearchHistory(')
          ..write('id: $id, ')
          ..write('searchItemId: $searchItemId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, searchItemId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SearchHistory &&
          other.id == this.id &&
          other.searchItemId == this.searchItemId);
}

class SearchHistorysCompanion extends UpdateCompanion<SearchHistory> {
  final Value<int> id;
  final Value<String?> searchItemId;
  const SearchHistorysCompanion({
    this.id = const Value.absent(),
    this.searchItemId = const Value.absent(),
  });
  SearchHistorysCompanion.insert({
    this.id = const Value.absent(),
    this.searchItemId = const Value.absent(),
  });
  static Insertable<SearchHistory> custom({
    Expression<int>? id,
    Expression<String>? searchItemId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (searchItemId != null) 'searchItemId': searchItemId,
    });
  }

  SearchHistorysCompanion copyWith(
      {Value<int>? id, Value<String?>? searchItemId}) {
    return SearchHistorysCompanion(
      id: id ?? this.id,
      searchItemId: searchItemId ?? this.searchItemId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (searchItemId.present) {
      map['searchItemId'] = Variable<String>(searchItemId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SearchHistorysCompanion(')
          ..write('id: $id, ')
          ..write('searchItemId: $searchItemId')
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
  final VerificationMeta _searchItemIdMeta =
      const VerificationMeta('searchItemId');
  late final GeneratedColumn<String> searchItemId = GeneratedColumn<String>(
      'searchItemId', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [id, searchItemId];
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
    if (data.containsKey('searchItemId')) {
      context.handle(
          _searchItemIdMeta,
          searchItemId.isAcceptableOrUnknown(
              data['searchItemId']!, _searchItemIdMeta));
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
      searchItemId: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}searchItemId']),
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
