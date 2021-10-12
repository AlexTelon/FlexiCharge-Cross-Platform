import 'package:flexicharge/models/payment_method_category.dart';
import 'package:flutter/foundation.dart';

class TransactionSession {
  int transactionID = 0;
  String userID = "";
  int chargerID = 0;
  double pricePerKwh = 0;
  String sessionID = "";
  String clientToken = "";
  // late List<PaymentMethodCategory> paymentMethodCategories;
  bool paymentConfirmed = false;
  bool isKlarnaPayment = true;
  int timestamp = 0;
  double kwhTransfered = 0;
  double currentChargePercentage = 0;
  int paymentID = 0;

  TransactionSession();

  TransactionSession.fromTransactionSession(
      {required this.transactionID,
      required this.userID,
      required this.chargerID,
      required this.pricePerKwh,
      required this.sessionID,
      required this.clientToken,
      // required this.paymentMethodCategories,
      required this.paymentConfirmed,
      required this.isKlarnaPayment,
      required this.timestamp,
      required this.kwhTransfered,
      required this.currentChargePercentage,
      required this.paymentID});

  TransactionSession.fromJson(Map<String, dynamic> json) {
    transactionID = json['transactionID'] ?? '0';
    userID = json['userID'];
    chargerID = json['chargerID'] ?? '0';
    pricePerKwh = double.parse(json['pricePerKwh'] ?? "0");
    sessionID = json['session_id'];
    clientToken = json['client_token'];
    // paymentMethodCategories = json['payment_method_categories'] ?? '';
    paymentConfirmed = json['paymentConfirmed'] ?? 'false';
    isKlarnaPayment = json['isKlarnaPayment'] ?? 'true';
    timestamp = json['timestamp'] ?? '';
    kwhTransfered = double.parse(json['kwhTransfered'] ?? '0');
    currentChargePercentage =
        double.parse(json['currentChargePercentage'] ?? '0');
    paymentID = int.parse(json['paymentID'] ?? '0');
  }
}
