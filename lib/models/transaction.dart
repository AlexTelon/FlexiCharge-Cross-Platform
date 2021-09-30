import 'package:flexicharge/models/charger.dart';

class Transaction {
  int id = -1;
  bool isKlarnaPayment = true;
  int kwhTransfered = 0;
  int currentChargePercentage = 0;
  double pricePerKwh = 0;
  int timestamp = -1;
  int paymentID = -1;
  int userID = -1;
  int chargerID = -1;


  Transaction();
  Transaction.fromTransanction({
    required this.id,
    required this.isKlarnaPayment,
    required this.kwhTransfered,
    required this.currentChargePercentage,
    required this.pricePerKwh,
    required this.timestamp,
    required this.paymentID,
    required this.userID,
    required this.chargerID,
  });

  Transaction.fromJson(Map<String, dynamic> json) {
    id = json['transactionID'];
    isKlarnaPayment = json['isKlarnaPayment'];
    kwhTransfered = json['kwhTransfered'];
    currentChargePercentage = json['currentChargePercentage'];
    pricePerKwh = json['pricePerKwh'];
    timestamp = json['timestamp'];
    paymentID = json['paymentID'];
    userID = json['userID'];
    chargerID = json['chargerID'];
  }
}
