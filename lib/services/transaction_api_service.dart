import 'dart:convert';
import 'package:flexicharge/enums/error_codes.dart';
import 'package:flexicharge/models/api.dart';
import 'package:flexicharge/models/transaction.dart';
import 'package:http/http.dart' as http;

/// It's a class that makes requests to the server and returns a Transaction object
class TransactionApiService {
  var client = new http.Client();

  /// It takes an id, makes a get request to the server, and returns a
  /// transaction object
  ///
  /// Args:
  ///   id (int): The id of the transaction to be retrieved
  ///
  /// Returns:
  ///   A Future<Transaction>
  Future<Transaction> getTransactionById(int id) async {
    var response = await client.get(Uri.parse('${API.url}/transactions/$id'));

    switch (response.statusCode) {
      case 200:
        var parsedTransaction = json.decode(response.body);
        var transactionFromJson = Transaction.fromJson(parsedTransaction);
        return transactionFromJson;
      case 404:
        throw Exception(ErrorCodes.notFound);
      case 500:
        throw Exception(ErrorCodes.internalError);
      default:
        throw Exception(ErrorCodes.internalError);
    }
  }

  /// It takes an id, makes a get request to the server, and returns a list
  /// of transactions
  ///
  /// Args:
  ///   id (int): the id of the user
  ///
  /// Returns:
  ///   A list of transactions.
  Future<List<Transaction>> getTransactionsByUserId(int id) async {
    var transactions = <Transaction>[];
    var response = await client
        .get(Uri.parse('${API.url}/transactions/userTransactions/$id'));

    switch (response.statusCode) {
      case 200:
        var parsedTransactions = json.decode(response.body) as List<dynamic>;
        for (var trans in parsedTransactions) {
          transactions.add(Transaction.fromJson(trans));
        }
        return transactions;
      case 404:
        throw Exception(ErrorCodes.notFound);
      case 500:
        throw Exception(ErrorCodes.internalError);
      default:
        throw Exception(ErrorCodes.internalError);
    }
  }

  /// It takes an id, makes a get request to the server, and returns a list
  /// of transactions
  ///
  /// Args:
  ///   id (int): the id of the charger
  ///
  /// Returns:
  ///   A list of transactions.
  Future<List<Transaction>> getTransactionsByChargerId(int id) async {
    var transactions = <Transaction>[];
    var response = await client
        .get(Uri.parse('${API.url}/transactions/chargerTransactions/$id'));

    switch (response.statusCode) {
      case 200:
        var parsedTransactions = json.decode(response.body) as List<dynamic>;
        for (var trans in parsedTransactions) {
          transactions.add(Transaction.fromJson(trans));
        }
        return transactions;
      case 404:
        throw Exception(ErrorCodes.notFound);
      case 500:
        throw Exception(ErrorCodes.internalError);
      default:
        throw Exception(ErrorCodes.internalError);
    }
  }

  /// It takes in 3 parameters, chargerId, userId, and meterStart. It then
  /// sends a POST request to the server with the parameters as the body
  ///
  /// Args:
  ///   chargerId (int): The id of the charger that the user is charging at
  ///   userId (int): The user's ID
  ///   meterStart (int): The meter reading when the user starts charging.
  Future<void> createTransaction(
      int chargerId, int userId, int meterStart) async {
    await client
        .post(
          Uri.parse('${API.url}/transactions'),
          headers: API.defaultRequestHeaders,
          body: jsonEncode(<String, int>{
            'chargerID': chargerId,
            'userID': userId,
            'meterStart': meterStart,
          }),
        )
        .then((result) => print(result));
  }

  /// It takes a transactionId and a meterStop, and updates the meterStop of
  /// the transaction with the given transactionId
  ///
  /// Args:
  ///   transactionId (int): The id of the transaction that you want to update.
  ///   meterStop (int): The meter stop value to be updated
  Future<void> updateMeterStopForTransaction(
      int transactionId, int meterStop) async {
    await client
        .put(
          Uri.parse('${API.url}/transactions/meter/$transactionId'),
          headers: API.defaultRequestHeaders,
          body: jsonEncode(<String, int>{
            'meterStop': meterStop,
          }),
        )
        .then((result) => print(result));
  }

  /// It takes a transactionId and a paymentId and updates the transaction
  /// with the paymentId
  ///
  /// Args:
  ///   transactionId (int): The id of the transaction that you want to update.
  ///   paymentId (int): The id of the payment that was created
  Future<void> updatePaymentIdForTransaction(
      int transactionId, int paymentId) async {
    await client
        .put(
          Uri.parse('${API.url}/transactions/payment/$transactionId'),
          headers: API.defaultRequestHeaders,
          body: jsonEncode(<String, int>{
            'paymentID': paymentId,
          }),
        )
        .then((result) => print(result));
  }

  /// It takes two parameters, userId and chargerId, and returns a Transaction
  /// object
  ///
  /// Args:
  ///   userId (int): 1
  ///   chargerId (int): 1
  ///
  /// Returns:
  ///   The response is a JSON object containing the following:
  Future<Transaction> createKlarnaPaymentSession(
      int? userId, int chargerId) async {
    var response = await client.post(Uri.parse('${API.url}/transactions'),
        headers: API.defaultRequestHeaders,
        encoding: Encoding.getByName('utf-8'),
        //These parameters do not appear to make a difference
        //since the functionality on the backend is not implemented.
        body: json.encode(<String, dynamic>{
          'chargerID': chargerId,
          'isKlarnaPayment': true
        }));
    switch (response.statusCode) {
      case 201:
        var transaction = json.decode(response.body) as Map<String, dynamic>;
        var parsedSession = Transaction.fromJson(transaction);
        return parsedSession;
      case 400:
        throw Exception(ErrorCodes.badRequest);
      case 404:
        throw Exception(ErrorCodes.notFound);
      case 500:
        throw Exception(ErrorCodes.internalError);
      default:
        throw Exception(ErrorCodes.internalError);
    }
  }

  /// The request returns the updated transaction object,
  /// If everything goes as expected, it will contain a paymentId.
  Future<Transaction> createKlarnaOrder(
    int transactionId,
    String authToken,
  ) async {
    var response = await client.put(
        Uri.parse('${API.url}/transactions/start/$transactionId'),
        headers: API.defaultRequestHeaders,
        body: jsonEncode(<String, dynamic>{
          'transactionID': transactionId,
          'authorization_token': authToken
        }));

    switch (response.statusCode) {
      case 200:
        var transaction = json.decode(response.body) as Map<String, dynamic>;
        if (transaction.isEmpty) throw Exception(ErrorCodes.emptyResponse);
        var parsedSession = Transaction.fromJson(transaction);

        print("Klarna updatedSession paymentID: " +
            parsedSession.paymentID.toString());
        return parsedSession;
      case 400:
        print(response.body);
        throw Exception(ErrorCodes.badRequest);
      case 404:
        print(response.body);
        throw Exception(ErrorCodes.notFound);
      case 500:
        print(response.body);
        throw Exception(ErrorCodes.internalError);
      default:
        throw Exception("default: " + ErrorCodes.internalError.toString());
    }
  }

  /// The request will return an updated transaction object which contains
  /// paymentConfirmed == true.
  Future<Transaction> stopCharging(int transactionId) async {
    var response = await client.put(
        Uri.parse('${API.url}/transactions/stop/$transactionId'),
        headers: API.defaultRequestHeaders);

    switch (response.statusCode) {
      case 200:
        // We get a List with a single Transaction object in response
        var list = json.decode(response.body) as List<dynamic>;
        if (list.isEmpty) throw Exception(ErrorCodes.emptyResponse);
        var parsedSession = Transaction.fromJson(list.first);
        print("Klarna updatedSession paymentConfirmed : " +
            parsedSession.paymentConfirmed.toString());
        return parsedSession;
      case 400:
        throw Exception(ErrorCodes.badRequest);
      case 404:
        throw Exception(ErrorCodes.notFound);
      case 500:
        throw Exception(ErrorCodes.internalError);
      default:
        throw Exception(ErrorCodes.internalError);
    }
  }
}
