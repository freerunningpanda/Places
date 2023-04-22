// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// DriftDatabaseGenerator
// **************************************************************************

// ignore_for_file: type=lint
class SearchHistory extends DataClass implements Insertable<SearchHistory> {
  final int id;
  final String title;
  const SearchHistory({required this.id, required this.title});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    return map;
  }

  SearchHistorysCompanion toCompanion(bool nullToAbsent) {
    return SearchHistorysCompanion(
      id: Value(id),
      title: Value(title),
    );
  }

  factory SearchHistory.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SearchHistory(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
    };
  }

  SearchHistory copyWith({int? id, String? title}) => SearchHistory(
        id: id ?? this.id,
        title: title ?? this.title,
      );
  @override
  String toString() {
    return (StringBuffer('SearchHistory(')
          ..write('id: $id, ')
          ..write('title: $title')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SearchHistory &&
          other.id == this.id &&
          other.title == this.title);
}

class SearchHistorysCompanion extends UpdateCompanion<SearchHistory> {
  final Value<int> id;
  final Value<String> title;
  const SearchHistorysCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
  });
  SearchHistorysCompanion.insert({
    this.id = const Value.absent(),
    required String title,
  }) : title = Value(title);
  static Insertable<SearchHistory> custom({
    Expression<int>? id,
    Expression<String>? title,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
    });
  }

  SearchHistorysCompanion copyWith({Value<int>? id, Value<String>? title}) {
    return SearchHistorysCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SearchHistorysCompanion(')
          ..write('id: $id, ')
          ..write('title: $title')
          ..write(')'))
        .toString();
  }
}

class $SearchHistorysTable extends SearchHistorys
    with TableInfo<$SearchHistorysTable, SearchHistory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SearchHistorysTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 16),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, title];
  @override
  String get aliasedName => _alias ?? 'search_historys';
  @override
  String get actualTableName => 'search_historys';
  @override
  VerificationContext validateIntegrity(Insertable<SearchHistory> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
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
      title: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
    );
  }

  @override
  $SearchHistorysTable createAlias(String alias) {
    return $SearchHistorysTable(attachedDatabase, alias);
  }
}

class DbPlace extends DataClass implements Insertable<DbPlace> {
  final int? index;
  final int id;
  final double lat;
  final double lng;
  final String name;
  final String urls;
  final String placeType;
  final String description;
  bool isFavorite;
  bool isSearchScreen;
  DbPlace(
      {this.index,
      required this.id,
      required this.lat,
      required this.lng,
      required this.name,
      required this.urls,
      required this.placeType,
      required this.description,
      this.isFavorite = false,
      this.isSearchScreen = false});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || index != null) {
      map['index'] = Variable<int>(index);
    }
    map['id'] = Variable<int>(id);
    map['lat'] = Variable<double>(lat);
    map['lng'] = Variable<double>(lng);
    map['name'] = Variable<String>(name);
    map['urls'] = Variable<String>(urls);
    map['place_type'] = Variable<String>(placeType);
    map['description'] = Variable<String>(description);
    map['is_favorite'] = Variable<bool>(isFavorite);
    map['is_search_screen'] = Variable<bool>(isSearchScreen);
    return map;
  }

  DbPlacesCompanion toCompanion(bool nullToAbsent) {
    return DbPlacesCompanion(
      index:
          index == null && nullToAbsent ? const Value.absent() : Value(index),
      id: Value(id),
      lat: Value(lat),
      lng: Value(lng),
      name: Value(name),
      urls: Value(urls),
      placeType: Value(placeType),
      description: Value(description),
      isFavorite: Value(isFavorite),
      isSearchScreen: Value(isSearchScreen),
    );
  }

  factory DbPlace.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbPlace(
      index: serializer.fromJson<int?>(json['index']),
      id: serializer.fromJson<int>(json['id']),
      lat: serializer.fromJson<double>(json['lat']),
      lng: serializer.fromJson<double>(json['lng']),
      name: serializer.fromJson<String>(json['name']),
      urls: serializer.fromJson<String>(json['urls']),
      placeType: serializer.fromJson<String>(json['placeType']),
      description: serializer.fromJson<String>(json['description']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      isSearchScreen: serializer.fromJson<bool>(json['isSearchScreen']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'index': serializer.toJson<int?>(index),
      'id': serializer.toJson<int>(id),
      'lat': serializer.toJson<double>(lat),
      'lng': serializer.toJson<double>(lng),
      'name': serializer.toJson<String>(name),
      'urls': serializer.toJson<String>(urls),
      'placeType': serializer.toJson<String>(placeType),
      'description': serializer.toJson<String>(description),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'isSearchScreen': serializer.toJson<bool>(isSearchScreen),
    };
  }

  DbPlace copyWith(
          {Value<int?> index = const Value.absent(),
          int? id,
          double? lat,
          double? lng,
          String? name,
          String? urls,
          String? placeType,
          String? description,
          bool? isFavorite,
          bool? isSearchScreen}) =>
      DbPlace(
        index: index.present ? index.value : this.index,
        id: id ?? this.id,
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
        name: name ?? this.name,
        urls: urls ?? this.urls,
        placeType: placeType ?? this.placeType,
        description: description ?? this.description,
        isFavorite: isFavorite ?? this.isFavorite,
        isSearchScreen: isSearchScreen ?? this.isSearchScreen,
      );
  @override
  String toString() {
    return (StringBuffer('DbPlace(')
          ..write('index: $index, ')
          ..write('id: $id, ')
          ..write('lat: $lat, ')
          ..write('lng: $lng, ')
          ..write('name: $name, ')
          ..write('urls: $urls, ')
          ..write('placeType: $placeType, ')
          ..write('description: $description, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('isSearchScreen: $isSearchScreen')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(index, id, lat, lng, name, urls, placeType,
      description, isFavorite, isSearchScreen);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbPlace &&
          other.index == this.index &&
          other.id == this.id &&
          other.lat == this.lat &&
          other.lng == this.lng &&
          other.name == this.name &&
          other.urls == this.urls &&
          other.placeType == this.placeType &&
          other.description == this.description &&
          other.isFavorite == this.isFavorite &&
          other.isSearchScreen == this.isSearchScreen);
}

class DbPlacesCompanion extends UpdateCompanion<DbPlace> {
  final Value<int?> index;
  final Value<int> id;
  final Value<double> lat;
  final Value<double> lng;
  final Value<String> name;
  final Value<String> urls;
  final Value<String> placeType;
  final Value<String> description;
  final Value<bool> isFavorite;
  final Value<bool> isSearchScreen;
  const DbPlacesCompanion({
    this.index = const Value.absent(),
    this.id = const Value.absent(),
    this.lat = const Value.absent(),
    this.lng = const Value.absent(),
    this.name = const Value.absent(),
    this.urls = const Value.absent(),
    this.placeType = const Value.absent(),
    this.description = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.isSearchScreen = const Value.absent(),
  });
  DbPlacesCompanion.insert({
    this.index = const Value.absent(),
    required int id,
    required double lat,
    required double lng,
    required String name,
    required String urls,
    required String placeType,
    required String description,
    required bool isFavorite,
    required bool isSearchScreen,
  })  : id = Value(id),
        lat = Value(lat),
        lng = Value(lng),
        name = Value(name),
        urls = Value(urls),
        placeType = Value(placeType),
        description = Value(description),
        isFavorite = Value(isFavorite),
        isSearchScreen = Value(isSearchScreen);
  static Insertable<DbPlace> custom({
    Expression<int>? index,
    Expression<int>? id,
    Expression<double>? lat,
    Expression<double>? lng,
    Expression<String>? name,
    Expression<String>? urls,
    Expression<String>? placeType,
    Expression<String>? description,
    Expression<bool>? isFavorite,
    Expression<bool>? isSearchScreen,
  }) {
    return RawValuesInsertable({
      if (index != null) 'index': index,
      if (id != null) 'id': id,
      if (lat != null) 'lat': lat,
      if (lng != null) 'lng': lng,
      if (name != null) 'name': name,
      if (urls != null) 'urls': urls,
      if (placeType != null) 'place_type': placeType,
      if (description != null) 'description': description,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (isSearchScreen != null) 'is_search_screen': isSearchScreen,
    });
  }

  DbPlacesCompanion copyWith(
      {Value<int?>? index,
      Value<int>? id,
      Value<double>? lat,
      Value<double>? lng,
      Value<String>? name,
      Value<String>? urls,
      Value<String>? placeType,
      Value<String>? description,
      Value<bool>? isFavorite,
      Value<bool>? isSearchScreen}) {
    return DbPlacesCompanion(
      index: index ?? this.index,
      id: id ?? this.id,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      name: name ?? this.name,
      urls: urls ?? this.urls,
      placeType: placeType ?? this.placeType,
      description: description ?? this.description,
      isFavorite: isFavorite ?? this.isFavorite,
      isSearchScreen: isSearchScreen ?? this.isSearchScreen,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (index.present) {
      map['index'] = Variable<int>(index.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (lat.present) {
      map['lat'] = Variable<double>(lat.value);
    }
    if (lng.present) {
      map['lng'] = Variable<double>(lng.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (urls.present) {
      map['urls'] = Variable<String>(urls.value);
    }
    if (placeType.present) {
      map['place_type'] = Variable<String>(placeType.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (isSearchScreen.present) {
      map['is_search_screen'] = Variable<bool>(isSearchScreen.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DbPlacesCompanion(')
          ..write('index: $index, ')
          ..write('id: $id, ')
          ..write('lat: $lat, ')
          ..write('lng: $lng, ')
          ..write('name: $name, ')
          ..write('urls: $urls, ')
          ..write('placeType: $placeType, ')
          ..write('description: $description, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('isSearchScreen: $isSearchScreen')
          ..write(')'))
        .toString();
  }
}

class $DbPlacesTable extends DbPlaces with TableInfo<$DbPlacesTable, DbPlace> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DbPlacesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _indexMeta = const VerificationMeta('index');
  @override
  late final GeneratedColumn<int> index = GeneratedColumn<int>(
      'index', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _latMeta = const VerificationMeta('lat');
  @override
  late final GeneratedColumn<double> lat = GeneratedColumn<double>(
      'lat', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  final VerificationMeta _lngMeta = const VerificationMeta('lng');
  @override
  late final GeneratedColumn<double> lng = GeneratedColumn<double>(
      'lng', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  final VerificationMeta _urlsMeta = const VerificationMeta('urls');
  @override
  late final GeneratedColumn<String> urls = GeneratedColumn<String>(
      'urls', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _placeTypeMeta = const VerificationMeta('placeType');
  @override
  late final GeneratedColumn<String> placeType = GeneratedColumn<String>(
      'place_type', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _isFavoriteMeta = const VerificationMeta('isFavorite');
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
      'is_favorite', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK ("is_favorite" IN (0, 1))');
  final VerificationMeta _isSearchScreenMeta =
      const VerificationMeta('isSearchScreen');
  @override
  late final GeneratedColumn<bool> isSearchScreen = GeneratedColumn<bool>(
      'is_search_screen', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK ("is_search_screen" IN (0, 1))');
  @override
  List<GeneratedColumn> get $columns => [
        index,
        id,
        lat,
        lng,
        name,
        urls,
        placeType,
        description,
        isFavorite,
        isSearchScreen
      ];
  @override
  String get aliasedName => _alias ?? 'db_places';
  @override
  String get actualTableName => 'db_places';
  @override
  VerificationContext validateIntegrity(Insertable<DbPlace> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('index')) {
      context.handle(
          _indexMeta, index.isAcceptableOrUnknown(data['index']!, _indexMeta));
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('lat')) {
      context.handle(
          _latMeta, lat.isAcceptableOrUnknown(data['lat']!, _latMeta));
    } else if (isInserting) {
      context.missing(_latMeta);
    }
    if (data.containsKey('lng')) {
      context.handle(
          _lngMeta, lng.isAcceptableOrUnknown(data['lng']!, _lngMeta));
    } else if (isInserting) {
      context.missing(_lngMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('urls')) {
      context.handle(
          _urlsMeta, urls.isAcceptableOrUnknown(data['urls']!, _urlsMeta));
    } else if (isInserting) {
      context.missing(_urlsMeta);
    }
    if (data.containsKey('place_type')) {
      context.handle(_placeTypeMeta,
          placeType.isAcceptableOrUnknown(data['place_type']!, _placeTypeMeta));
    } else if (isInserting) {
      context.missing(_placeTypeMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
          _isFavoriteMeta,
          isFavorite.isAcceptableOrUnknown(
              data['is_favorite']!, _isFavoriteMeta));
    } else if (isInserting) {
      context.missing(_isFavoriteMeta);
    }
    if (data.containsKey('is_search_screen')) {
      context.handle(
          _isSearchScreenMeta,
          isSearchScreen.isAcceptableOrUnknown(
              data['is_search_screen']!, _isSearchScreenMeta));
    } else if (isInserting) {
      context.missing(_isSearchScreenMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {index};
  @override
  DbPlace map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbPlace(
      index: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}index']),
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      lat: attachedDatabase.options.types
          .read(DriftSqlType.double, data['${effectivePrefix}lat'])!,
      lng: attachedDatabase.options.types
          .read(DriftSqlType.double, data['${effectivePrefix}lng'])!,
      name: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      urls: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}urls'])!,
      placeType: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}place_type'])!,
      description: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      isFavorite: attachedDatabase.options.types
          .read(DriftSqlType.bool, data['${effectivePrefix}is_favorite'])!,
      isSearchScreen: attachedDatabase.options.types
          .read(DriftSqlType.bool, data['${effectivePrefix}is_search_screen'])!,
    );
  }

  @override
  $DbPlacesTable createAlias(String alias) {
    return $DbPlacesTable(attachedDatabase, alias);
  }
}

abstract class _$AppDb extends GeneratedDatabase {
  _$AppDb(QueryExecutor e) : super(e);
  late final $SearchHistorysTable searchHistorys = $SearchHistorysTable(this);
  late final $DbPlacesTable dbPlaces = $DbPlacesTable(this);
  @override
  Iterable<TableInfo<Table, dynamic>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [searchHistorys, dbPlaces];
}