/// The class is a model for a transaction. It has a bunch of properties,
/// and a constructor that takes a map of strings and dynamic values
class Transaction {
  String klarnaClientToken = "";
  String klarnaSessionID = "";
  int transactionID = -1;
  int startTimestamp = -1;
  int kwhTransferred = -1;
  int currentChargePercentage = -1;
  int pricePerKwh = -1;
  int connectorID = -1;
  String userID = "";
  int price = -1;
  int endTimeStamp = -1;
  int discount = -1;

  Transaction();

  @override
  String toString() {
    return 'Transaction ID: $transactionID startTimeStamp: $startTimestamp endTimeStamp: $endTimeStamp';
  }

  /// The function `updateFrom` updates the current object's properties with the corresponding properties
  /// from another `Transaction` object if they are not empty or have a specific value.
  ///
  /// Args:
  ///   other (Transaction): The "other" parameter is an instance of the Transaction class that contains
  /// the updated values for the transaction attributes.
  void updateFrom(Transaction other) {
    if (other.klarnaClientToken != "") {
      klarnaClientToken = other.klarnaClientToken;
    }
    if (other.klarnaSessionID != "") {
      klarnaSessionID = other.klarnaSessionID;
    }
    if (other.transactionID != -1) {
      transactionID = other.transactionID;
    }
    if (other.startTimestamp != -1) {
      startTimestamp = other.startTimestamp;
    }
    if (other.kwhTransferred != -1) {
      kwhTransferred = other.kwhTransferred;
    }
    if (other.currentChargePercentage != -1) {
      currentChargePercentage = other.currentChargePercentage;
    }
    if (other.pricePerKwh != -1) {
      pricePerKwh = other.pricePerKwh;
    }
    if (other.connectorID != -1) {
      connectorID = other.connectorID;
    }
    if (other.userID != "") {
      userID = other.userID;
    }
    if (other.price != -1) {
      price = other.price;
    }
    if (other.endTimeStamp != -1) {
      endTimeStamp = other.endTimeStamp;
    }
    if (other.discount != -1) {
      discount = other.discount;
    }
  }

  Transaction.fromJson(Map<String, dynamic> json) {
    transactionID = json['transactionID'] ?? 0;
    klarnaClientToken = json['klarnaClientToken'] ?? "";
    klarnaSessionID = json['klarnaSessionID'] ?? "";
    startTimestamp = json['startTimestamp'] ?? 0;
    kwhTransferred = json['kwhTransferred'] ?? 0;
    currentChargePercentage = json['currentChargePercentage'] ?? 0;
    pricePerKwh = json['pricePerKWh'] ?? 0;
    connectorID = json['connectorID'] ?? 0;
    userID = json['userID'] ?? "";
    price = json['price'] ?? 0;
    endTimeStamp = json['endTimestamp'] ?? -1;
    discount = json['discount'] ?? 0;
  }
}
