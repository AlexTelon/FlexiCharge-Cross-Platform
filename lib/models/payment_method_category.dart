import 'package:flexicharge/models/asset_urls.dart';

/// The class PaymentMethodCategory has a property of type AssetsUrls,
/// which is a class that has a property of type String
/// This class is aimed at the Klarna integration
/// At the moment the class is not used. This class could be helpful in the future.
class PaymentMethodCategory {
  String id = "";
  String name = "";
  AssetsUrls assetUrls = AssetsUrls();

  PaymentMethodCategory();

  PaymentMethodCategory.fromPaymentMethodCategory({
    required this.id,
    required this.name,
    required this.assetUrls,
  });

  PaymentMethodCategory.fromJson(Map<String, dynamic> json) {
    id = json['identifier'];
    name = json['name'];
    assetUrls = json['asset_urls'];
  }
}
