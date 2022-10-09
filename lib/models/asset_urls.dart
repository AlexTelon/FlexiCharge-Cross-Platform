/// The above class is a Dart class that is used to parse the JSON data
/// from the API
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
