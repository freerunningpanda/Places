import 'dart:convert';

class PlaceRequest {
  final int id;
  final double lat;
  final double lng;
  final String name;
  final List<String> urls;
  final String placeType;
  final String description;

  PlaceRequest({
    required this.id,
    required this.lat,
    required this.lng,
    required this.name,
    required this.urls,
    required this.placeType,
    required this.description,
  });

    factory PlaceRequest.fromJson(Map<String, dynamic> json) => PlaceRequest(
        id: json['id'] as int,
        lat: json['lat'] as double,
        lng: json['lng'] as double,
        name: json['name'] as String,
        // ignore: avoid_annotating_with_dynamic
        urls: (json['urls'] as List<dynamic>).map((dynamic e) => e as String).toList(),
        placeType: json['placeType'] as String,
        description: json['description'] as String,
      );

  @override
  String toString() {
    return 'Название: $name. Тип: $placeType. Ширина: $lat. Долгота: $lng.';
  }

    static Map<String, dynamic> toJson(PlaceRequest place) {
    return <String, dynamic>{
      'id': place.id,
      'lat': place.lat,
      'lng': place.lng,
      'name': place.name,
      'urls': List<dynamic>.from(
        place.urls.map<String>((url) => url),
      ),
      'placeType': place.placeType,
      'description': place.description,
    };
  }

  static String encode(Set<PlaceRequest> places) => json.encode(
        places.map<Map<String, dynamic>>(PlaceRequest.toJson).toList(),
      );

  static Set<PlaceRequest> decode(String places) => (json.decode(places) as List<dynamic>)
      // ignore: avoid_annotating_with_dynamic
      .map<PlaceRequest>((dynamic place) => PlaceRequest.fromJson(place as Map<String, dynamic>))
      .toSet();
}
