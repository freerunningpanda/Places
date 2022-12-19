class PlacesFilterRequest {
  final double lat;
  final double lng;
  final double radius;
  final List<String> typeFilter;
  final String nameFilter;

  PlacesFilterRequest({
    required this.lat,
    required this.lng,
    required this.radius,
    required this.typeFilter,
    required this.nameFilter,
  });

  factory PlacesFilterRequest.fromJson(Map<String, dynamic> json) => PlacesFilterRequest(
        lat: (json['lat'] as num).toDouble(),
        lng: (json['lng'] as num).toDouble(),
        radius: (json['radius'] as num).toDouble(),
        typeFilter: json['typeFilter'] as List<String>,
        nameFilter: json['nameFilter'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'lat': lat,
        'lng': lng,
        'radius': radius,
        'typeFilter': typeFilter,
        'nameFilter': nameFilter,
      };
}
