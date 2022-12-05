class Place {
  final int id;
  final double lat;
  final double lon;
  final String name;
  final List<String> urls;
  final String placeType;
  final String description;

  Place({
    required this.id,
    required this.lat,
    required this.lon,
    required this.name,
    required this.urls,
    required this.placeType,
    required this.description,
  });

  @override
  String toString() {
    return 'Название: $name. Тип: $placeType. Ширина: $lat. Долгота: $lon.';
  }
}
