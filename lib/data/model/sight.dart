import 'package:equatable/equatable.dart';

class Sight extends Equatable {
  final String name;
  final double lat;
  final double lot;
  final String? url;
  final String details;
  final String type;

  @override
  List<Object?> get props => [name, lat, lot, url, details, type];

  const Sight({
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
