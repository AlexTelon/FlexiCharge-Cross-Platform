import 'dart:convert';
import 'package:flexicharge/enums/error_codes.dart';
import 'package:flexicharge/models/transaction.dart';
import 'package:http/http.dart' as http;

class TransactionApiService {
  static const endPoint = "http://54.220.194.65:8080";
  var client = new http.Client();

  Future<Transaction> getTransactionById(int id) async {
    var response = await client.get(Uri.parse('$endPoint/transactions/$id'));

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

  Future<List<Transaction>> getTransactionsByUserId(int id) async {
    var transactions = <Transaction>[];
    var response = await client
        .get(Uri.parse('$endPoint/transactions/userTransactions/$id'));

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

  Future<List<Transaction>> getTransactionsByChargerId(int id) async {
    var transactions = <Transaction>[];
    var response = await client
        .get(Uri.parse('$endPoint/transactions/chargerTransactions/$id'));

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

  Future<void> createTransaction(
      int chargerId, int userId, int meterStart) async {
    await client
        .post(
          Uri.parse('$endPoint/transactions'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, int>{
            'chargerID': chargerId,
            'userID': userId,
            'meterStart': meterStart,
          }),
        )
        .then((result) => print(result));
  }

  Future<void> updateMeterStopForTransaction(
      int transactionId, int meterStop) async {
    await client
        .put(
          Uri.parse('$endPoint/transactions/meter/$transactionId'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, int>{
            'meterStop': meterStop,
          }),
        )
        .then((result) => print(result));
  }

  Future<void> updatePaymentIdForTransaction(
      int transactionId, int paymentId) async {
    await client
        .put(
          Uri.parse('$endPoint/transactions/payment/$transactionId'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, int>{
            'paymentID': paymentId,
          }),
        )
        .then((result) => print(result));
  }

  Future<Transaction> createKlarnaPaymentSession(
      int? userId, int chargerId) async {
    var response =
        await client.post(Uri.parse('$endPoint/transactions/session'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, int?>{
              'userID': userId,
              'chargerID': chargerId,
            }));
    print("Klarna statusCode: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 201:
        var transaction = json.decode(response.body) as Map<String, dynamic>;
        var parsedSession = Transaction.fromJson(transaction);
        return parsedSession;
      case 400:
        throw Exception(ErrorCodes.notFound);
      case 500:
        throw Exception(ErrorCodes.internalError);
      default:
        throw Exception(ErrorCodes.internalError);
    }
  }

  // The request returns the updated transaction object,
  // If everything goes as expected, it will contain a paymentId.
  Future<Transaction> createKlarnaOrder(
      int transactionId, String authToken) async {
    var response = await client.post(Uri.parse('$endPoint/transactions/order'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'transactionID': transactionId,
          'authorization_token': authToken
        }));
    switch (response.statusCode) {
      case 201:
        var updatedTransactionSession =
            json.decode(response.body) as Map<String, dynamic>;
        var parsedSession = Transaction.fromJson(updatedTransactionSession);
        print("Klarna updatedSession paymentID: " +
            parsedSession.paymentID.toString());
        return parsedSession;
      case 400:
        throw Exception(ErrorCodes.badRequest);
      case 500:
        throw Exception(ErrorCodes.internalError);
      default:
        throw Exception(ErrorCodes.internalError);
    }
  }

  //the request will return an updated transaction object which contains paymentConfirmed == true.
  Future<Transaction> stopCharging(int transactionId) async {
    var response = await client.post(Uri.parse('$endPoint/transactions/stop'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, int>{'transactionID': transactionId}));
    switch (response.statusCode) {
      case 201:
        var updatedTransactionSession =
            json.decode(response.body) as Map<String, dynamic>;
        var parsedSession = Transaction.fromJson(updatedTransactionSession);
        print("Klarna updatedSession paymentConfirmed : " +
            parsedSession.paymentConfirmed.toString());
        return parsedSession;
      case 400:
        throw Exception(ErrorCodes.notFound);
      case 500:
        throw Exception(ErrorCodes.internalError);
      default:
        throw Exception(ErrorCodes.internalError);
    }
  }
}
