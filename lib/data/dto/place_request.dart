class PlaceRequest {
  final int id;
  final double lat;
  final double lon;
  final String name;
  final List<String> urls;
  final String placeType;
  final String description;

  PlaceRequest({
    required this.id,
    required this.lat,
    required this.lon,
    required this.name,
    required this.urls,
    required this.placeType,
    required this.description,
  });

    factory PlaceRequest.fromJson(Map<String, dynamic> json) => PlaceRequest(
        id: json['id'] as int,
        lat: json['lat'] as double,
        lon: json['lng'] as double,
        name: json['name'] as String,
        // ignore: avoid_annotating_with_dynamic
        urls: (json['urls'] as List<dynamic>).map((dynamic e) => e as String).toList(),
        placeType: json['placeType'] as String,
        description: json['description'] as String,
      );

  @override
  String toString() {
    return 'Название: $name. Тип: $placeType. Ширина: $lat. Долгота: $lon.';
  }
}
