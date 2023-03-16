import 'dart:convert';

class Place {
  final int id;
  final double lat;
  final double lng;
  final String name;
  final List<String> urls;
  final String placeType;
  final String description;
  bool isFavorite;

  Place({
    required this.id,
    required this.lat,
    required this.lng,
    required this.name,
    required this.urls,
    required this.placeType,
    required this.description,
    this.isFavorite = false,
  });

  factory Place.fromJson(Map<String, dynamic> json) => Place(
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
    return 'Название: $name. Тип: $placeType. Ширина: $lat. Долгота: $lng. В избранном: $isFavorite';
  }

  static Map<String, dynamic> toJson(Place place) {
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

  static String encode(Set<Place> places) => json.encode(
        places.map<Map<String, dynamic>>(Place.toJson).toList(),
      );

  static Set<Place> decode(String places) => (json.decode(places) as List<dynamic>)
      .map<Place>((dynamic place) => Place.fromJson(place as Map<String, dynamic>))
      .toSet();
}
