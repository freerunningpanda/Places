import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:places/blocs/visited/visited_screen_bloc.dart';
import 'package:places/data/database/database.dart';
import 'package:places/main_prod.dart';
import 'package:provider/provider.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapDataProvider {
  Future<void> buildRoute({
    required double lat,
    required double lng,
    required String title,
  }) async {
    final availableMaps = await MapLauncher.installedMaps;
    await availableMaps.first.showMarker(
      coords: Coords(lat, lng),
      title: title,
    );
  }

  Future<void> addToVisited(DbPlace place, BuildContext context) async {
    final id = Random().nextInt(784654) + 87843;
    final db = context.read<AppDb>();
    final isVisited = place.isVisited = true;
    context.read<VisitedScreenBloc>().add(
          AddToVisitedEvent(
            db: db,
            isVisited: isVisited,
            place: place,
          ),
        );
    await db.addPlace(
      place,
      isSearchScreen: false,
      id: id,
      isVisited: true,
    );
  }

  Future<void> getPosition() async {
    position = await Geolocator.getCurrentPosition();
    currentPoint = Point(latitude: position!.latitude, longitude: position!.longitude);
  }
}
