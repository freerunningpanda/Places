class Category {
  final String title;
  final String? assetName;
  bool isEnabled;

  Category({
    required this.title,
    this.assetName,
    this.isEnabled = false,
  });
}
