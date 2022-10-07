class Transaction {
  int transactionID = 0;
  String userID = "";
  int chargerID = 0;
  double pricePerKwh = 0;
  String sessionID = "";
  String clientToken = "";
  bool paymentConfirmed = false;
  bool isKlarnaPayment = true;
  int timestamp = 0;
  double kwhTransfered = 0;
  int currentChargePercentage = 0;
  String paymentID = '';

  Transaction();

  Transaction.fromTransaction({
    required this.transactionID,
    required this.userID,
    required this.chargerID,
    required this.pricePerKwh,
    required this.sessionID,
    required this.clientToken,
    required this.paymentConfirmed,
    required this.isKlarnaPayment,
    required this.timestamp,
    required this.kwhTransfered,
    required this.currentChargePercentage,
    required this.paymentID,
  });

  Transaction.fromJson(Map<String, dynamic> json) {
    transactionID = json['transactionID'] ?? 0;
    userID = json['userID'] ?? '';
    chargerID = json['chargerID'] ?? 0;
    pricePerKwh = double.parse(json['pricePerKwh'] ?? '0.0');
    sessionID = json['session_id'];
    clientToken = json['client_token'];
    paymentConfirmed = json['paymentConfirmed'] ?? false;
    isKlarnaPayment = json['isKlarnaPayment'] ?? true;
    timestamp = json['timestamp'] ?? 0;
    kwhTransfered = json['kwhTransfered'] ?? 0;
    currentChargePercentage = json['currentChargePercentage'] ?? 0;
    paymentID = json['paymentID'] ?? '';
  }
}
