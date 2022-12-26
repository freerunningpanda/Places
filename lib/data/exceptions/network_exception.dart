class NetworkException implements Exception {
  final String query;
  final String statusCode;
  
  NetworkException({
    required this.query,
    required this.statusCode,
  });

  @override
  String toString() {
    return "В запросе '$query' возникла ошибка: $statusCode";
  }
}
