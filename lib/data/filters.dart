class Filters {
  final String category;
  final String assetName;
  bool isEnabled;

  Filters({
    required this.category,
    required this.assetName,
    this.isEnabled = false,
  });
}
