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
        throw Exception("Not Found");
      case 500:
        throw Exception("Internal Server Error");
      default:
        throw Exception(ErrorCodes.internalError);
    }
  }

  Future<Transaction> getTransactionByUserId(int id) async {
    var response = await client
        .get(Uri.parse('$endPoint/transactions/userTransactions/$id'));

    switch (response.statusCode) {
      case 200:
        var parsedTransaction = json.decode(response.body) as Transaction;
        return parsedTransaction;
      case 404:
        throw Exception("Not Found");
      case 500:
        throw Exception("Internal Server Error");
      default:
        throw Exception(ErrorCodes.internalError);
    }
  }

  Future<Transaction> getTransactionByChargerId(int id) async {
    var response = await client
        .get(Uri.parse('$endPoint/transactions/chargerTransactions/$id'));

    switch (response.statusCode) {
      case 200:
        var parsedTransaction = json.decode(response.body) as Transaction;
        return parsedTransaction;
      case 404:
        throw Exception("Not Found");
      case 500:
        throw Exception("Internal Server Error");
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
}
