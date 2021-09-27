import 'package:flexicharge/models/charger.dart';

class Transaction {
  late int id;
  late double meterStart;
  late double meterStop;
  late double timeStamp;
  late int paymentID; //FK
  late int userID; //FK
  late int chargerID; //FK

  Transaction();
  Transaction.fromTransanction({
    required this.id,
    required this.meterStart,
    required this.meterStop,
    required this.paymentID,
    required this.userID,
    required this.chargerID,
  });

  Transaction.fromJson(Map<String, dynamic> json) {
    id = json['transactionID'];
    meterStart = json['meterStart'];
    meterStop = json['meterStop'];
    timeStamp = json['timestamp'];
    paymentID = json['paymentID'];
    userID = json['userID'];
    chargerID = json['chargerID'];
  }
}
