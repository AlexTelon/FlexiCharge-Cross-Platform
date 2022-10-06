// import 'package:http/http.dart' as http;

// class Register {
//   String email = '';
//   String verificationCode = '';
 
// }

// Future<Transaction> createKlarnaPaymentSession(
//       int? userId, int chargerId) async {
//     var response =
//         await client.post(Uri.parse('$endPoint/transactions/session'),
//             headers: <String, String>{
//               'Content-Type': 'application/json; charset=UTF-8',
//             },
//             encoding: Encoding.getByName('utf-8'),
//             body: json.encode(<String, int>{
//               'userID': 1, //TODO This needs to be replaced with actual value
//               'chargerID': chargerId,
//             }));
//     switch (response.statusCode) {
//       case 201:
//         var transaction = json.decode(response.body) as Map<String, dynamic>;
//         var parsedSession = Transaction.fromJson(transaction);
//         return parsedSession;
//       case 400:
//         throw Exception(ErrorCodes.badRequest);
//       case 404:
//         throw Exception(ErrorCodes.notFound);
//       case 500:
//         throw Exception(ErrorCodes.internalError);
//       default:
//         throw Exception(ErrorCodes.internalError);
//     }
//   }

//   // The request returns the updated transaction object,
//   // If everything goes as expected, it will contain a paymentId.
//   Future<Transaction> createKlarnaOrder(
//     int transactionId,
//     String authToken,
//   ) async {
//     var response = await client.put(
//         Uri.parse('$endPoint/transactions/start/$transactionId'),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode(<String, dynamic>{
//           'transactionID': transactionId,
//           'authorization_token': authToken
//         }));
