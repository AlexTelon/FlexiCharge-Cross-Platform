/// The class is a model for a transaction. It has a bunch of properties,
/// and a constructor that takes a map of strings and dynamic values
class OldTransaction {
  int transactionID = 0;
  String userID = "";
  int chargerID = 0;
  double pricePerKwh = 0;
  String sessionID = "";
  String clientToken = "";
  bool paymentConfirmed = false;
  bool isKlarnaPayment = true;
  int timestamp = 0;
  double kwhTransferred = 0;
  int currentChargePercentage = 0;
  String paymentID = '';

  OldTransaction();

  OldTransaction.fromTransaction({
    required this.transactionID,
    required this.userID,
    required this.chargerID,
    required this.pricePerKwh,
    required this.sessionID,
    required this.clientToken,
    required this.paymentConfirmed,
    required this.isKlarnaPayment,
    required this.timestamp,
    required this.kwhTransferred,
    required this.currentChargePercentage,
    required this.paymentID,
  });

  OldTransaction.fromJson(Map<String, dynamic> json) {
    transactionID = json['transactionID'] ?? 0;
    userID = json['userID'] ?? '';
    chargerID = json['connectorID'] ?? 0;
    pricePerKwh = double.parse(json['pricePerKwh'] ?? '0.0');
    sessionID = json['session_id'] ?? "";
    clientToken = json['klarna_consumer_token'] ?? "";
    paymentConfirmed = json['paymentConfirmed'] ?? false;
    isKlarnaPayment = json['isKlarnaPayment'] ?? true;
    timestamp = json['timestamp'] ?? 0;
    kwhTransferred = json['kwhTransfered'].toDouble() ?? 0;
    currentChargePercentage = json['currentChargePercentage'] ?? 0;
    paymentID = json['paymentID'] ?? '';
  }
}
