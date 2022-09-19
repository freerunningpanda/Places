class Sight {
  final String name;
  final double lat;
  final double lot;
  final String? url;
  final String details;
  final String type;

  Sight({
    required this.name,
    required this.lat,
    required this.lot,
    this.url,
    required this.details,
    required this.type,
  });

  @override
  String toString() {
    return 'Название: $name, Широта: $lat, Долгота: $lot, Ссылка: $url, Описание: $details, Тип: $type';
  }
}
