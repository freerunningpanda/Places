class Filters {
  final String title;
  final String assetName;
  bool isEnabled;

  Filters({
    required this.title,
    required this.assetName,
    this.isEnabled = false,
  });
}
