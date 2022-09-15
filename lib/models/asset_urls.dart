class AssetsUrls {
  String descriptive = "";
  String standard = "";

  AssetsUrls();

  AssetsUrls.fromAssetsUrls({
    required this.descriptive,
    required this.standard,
  });

  AssetsUrls.fromJson(Map<String, dynamic> json) {
    descriptive = json['descriptive'];
    standard = json['standard'];
  }
}
