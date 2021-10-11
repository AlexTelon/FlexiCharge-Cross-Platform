import 'package:flexicharge/models/payment_method_category.dart';

class Session {
  int transactionID = 0;
  int userID = 0;
  int chargerID = 0;
  double pricePerKwh = 0;
  String sessionID = "";
  String clientToken = "";
  late List<PaymentMethodCategory> paymentMethodCategories;
  bool paymentConfirmed = false;
  bool isKlarnaPayment = true;
  int timestamp = 0;
  double kwhTransfered = 0;
  double currentChargePercentage = 0;
  int paymentID = 0;

  Session();

  Session.fromJson(Map<String, dynamic> json) {
    transactionID = json['transactionID'];
    userID = json['userID'];
    chargerID = json['chargerID'];
    pricePerKwh = json['pricePerKwh'];
    sessionID = json['session_id'] ?? '';
    clientToken = json['client_token'] ?? '';
    paymentMethodCategories = json['payment_method_categories'];
    paymentConfirmed = json['paymentConfirmed'];
    isKlarnaPayment = json['isKlarnaPayment'];
    timestamp = json['timestamp'];
    kwhTransfered = json['kwhTransfered'];
    currentChargePercentage = json['currentChargePercentage'];
    paymentID = json['paymentID'];
  }
}
