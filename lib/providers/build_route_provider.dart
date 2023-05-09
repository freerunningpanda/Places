import 'package:map_launcher/map_launcher.dart';

class BuildRouteProvider {
  
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
}
