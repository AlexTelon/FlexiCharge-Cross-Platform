import 'dart:convert';
import 'package:flexicharge/enums/error_codes.dart';
import 'package:flexicharge/models/api.dart';
import 'package:flexicharge/models/transaction.dart';
import 'package:http/http.dart' as http;

class TransactionApiService {
  var client = new http.Client();

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

  Future<Transaction> createKlarnaPaymentSession(
      int? userId, int chargerId) async {
    var response =
        await client.post(Uri.parse('${API.url}/transactions/session'),
            headers: API.defaultRequestHeaders,
            encoding: Encoding.getByName('utf-8'),
            //These parameters do not appear to make a difference
            //since the functionality on the backend is not implemented.
            body: json.encode(<String, int>{
              'userID': 1,
              'chargerID': chargerId,
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

  // The request returns the updated transaction object,
  // If everything goes as expected, it will contain a paymentId.
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
      case 201:
        var list = json.decode(response.body) as List<Map<String, dynamic>>;
        if (list.isEmpty) throw Exception(ErrorCodes.emptyResponse);
        var parsedSession = Transaction.fromJson(list[0]);

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

  //the request will return an updated transaction object which contains paymentConfirmed == true.
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
