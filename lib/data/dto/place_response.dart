class PlaceResponse {
  final int id;
  final double lat;
  final double lon;
  final double distance;
  final String name;
  final List<String> urls;
  final String placeType;
  final String description;

  PlaceResponse({
    required this.id,
    required this.lat,
    required this.lon,
    required this.distance,
    required this.name,
    required this.urls,
    required this.placeType,
    required this.description,
  });

  factory PlaceResponse.fromJson(Map<String, dynamic> json) => PlaceResponse(
        id: json['id'] as int,
        lat: json['lat'] as double,
        lon: json['lng'] as double,
        distance: json['distance'] as double,
        name: json['name'] as String,
        // ignore: avoid_annotating_with_dynamic
        urls: (json['urls'] as List<dynamic>).map((dynamic e) => e as String).toList(),
        placeType: json['placeType'] as String,
        description: json['description'] as String,
      );

  @override
  String toString() {
    return 'Название: $name. Тип: $placeType. Ширина: $lat. Долгота: $lon. Дистанция: $distance';
  }
}
