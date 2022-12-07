class PlaceUI {
  final int id;
  final double lat;
  final double lon;
  final String name;
  final List<String> urls;
  final String placeType;
  final String description;

  PlaceUI({
    required this.id,
    required this.lat,
    required this.lon,
    required this.name,
    required this.urls,
    required this.placeType,
    required this.description,
  });
}
