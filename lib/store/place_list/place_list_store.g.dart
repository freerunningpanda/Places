// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_list_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PlaceListStore on PlaceListStoreBase, Store {
  late final _$getPlacesFutureAtom =
      Atom(name: 'PlaceListStoreBase.getPlacesFuture', context: context);

  @override
  ObservableFuture<List<Place>> get getPlacesFuture {
    _$getPlacesFutureAtom.reportRead();
    return super.getPlacesFuture;
  }

  @override
  set getPlacesFuture(ObservableFuture<List<Place>> value) {
    _$getPlacesFutureAtom.reportWrite(value, super.getPlacesFuture, () {
      super.getPlacesFuture = value;
    });
  }

  late final _$getPlacesAsyncAction =
      AsyncAction('PlaceListStoreBase.getPlaces', context: context);

  @override
  Future<void> getPlaces({bool isHidden = false}) {
    return _$getPlacesAsyncAction
        .run(() => super.getPlaces(isHidden: isHidden));
  }

  @override
  String toString() {
    return '''
getPlacesFuture: ${getPlacesFuture}
    ''';
  }
}
