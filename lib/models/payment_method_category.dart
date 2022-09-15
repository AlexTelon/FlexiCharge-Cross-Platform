import 'package:flexicharge/models/asset_urls.dart';

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
