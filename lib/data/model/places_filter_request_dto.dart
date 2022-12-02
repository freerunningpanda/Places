class PlacesFilterRequestDto {
  final double lat;
  final double lng;
  final double radius;
  final List<String> typeFilter;
  final String nameFilter;

  PlacesFilterRequestDto({
    required this.lat,
    required this.lng,
    required this.radius,
    required this.typeFilter,
    required this.nameFilter,
  });

  factory PlacesFilterRequestDto.fromJson(Map<String, dynamic> json) => PlacesFilterRequestDto(
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
