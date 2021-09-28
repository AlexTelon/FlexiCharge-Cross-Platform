import 'package:flexicharge/models/charger.dart';

class Transaction {
  int id = -1;
  int meterStart = -1;
  int meterStop = -1;
  int timeStamp = -1;
  int paymentID = -1;
  int userID = -1;
  int chargerID = -1;

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
