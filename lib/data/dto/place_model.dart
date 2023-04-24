class PlaceModel {
  final double lat;
  final double lng;
  final String name;
  final List<String> urls;
  final String placeType;
  final String description;

  const PlaceModel({
    required this.lat,
    required this.lng,
    required this.name,
    required this.urls,
    required this.placeType,
    required this.description,
  });

  PlaceModel.fromJson(Map<String, dynamic> json)
      : lat = json['lat'] as double,
        lng = json['lng'] as double,
        name = json['name'] as String,
        urls = List<String>.from(
          (json['urls'] as List).map<String>((dynamic e) => e as String),
        ),
        placeType = json['placeType'] as String,
        description = json['description'] as String;

  @override
  String toString() => 'PlaceModel(name: $name, url: $urls, title: $name, subtitle: $placeType})\n';

  Map<String, dynamic> toJson() => <String, dynamic>{
        'lat': lat,
        'lng': lng,
        'name': name,
        'urls': urls,
        'placeType': placeType,
        'description': description,
      };

  PlaceModel copyWith({
    double? lat,
    double? lng,
    String? name,
    List<String>? urls,
    String? placeType,
    String? description,
  }) {
    return PlaceModel(
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      name: name ?? this.name,
      urls: urls ?? this.urls,
      placeType: placeType ?? this.placeType,
      description: description ?? this.description,
    );
  }
}
