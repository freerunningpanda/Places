import 'dart:math';

abstract class CalculationDistance {
  static double distance(
    double startLat,
    double startLot,
    double endLat,
    double endLot,
  ) {
    const earthRadius = 6378137.0;
    final lat = _calcRadians(endLat - startLat);
    final lon = _calcRadians(endLot - startLot);

    final result = pow(sin(lat / 2), 2) +
        pow(sin(lon / 2), 2) *
            cos(
              _calcRadians(startLat),
            ) *
            cos(
              _calcRadians(endLat),
            );
    final square = 2 * asin(sqrt(result));

    return earthRadius * square;
  }
}

double _calcRadians(double degrees) {
  return degrees * pi / 180;
}
