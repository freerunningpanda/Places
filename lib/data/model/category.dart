class Category {
  final String title;
  final String? assetName;
  final String placeType;
  bool isEnabled;

  Category({
    required this.title,
    this.assetName,
    this.isEnabled = false,
    required this.placeType,
  });

  @override
  String toString() {
    return 'Имя категории: $title, Тип категории: $placeType\n';
  }
}
