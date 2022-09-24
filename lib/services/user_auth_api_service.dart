import 'dart:convert';
import 'package:flexicharge/models/registration.dart';
import 'package:flexicharge/app/app.locator.dart';
import 'package:flexicharge/enums/error_codes.dart';
import 'package:flexicharge/models/charger_point.dart';
import 'package:flexicharge/services/local_data.dart';
import 'package:http/http.dart' as http;

class UserApiService {
  static const endPoint = "http://18.202.253.30:8080";
  http.Client client = new http.Client();
  var chargerPoint = new ChargerPoint();
  LocalData _localData = locator<LocalData>();

//   Future<List<Charger>> register(registrationDetails) async {
//     var chargers = <Charger>[];
//     var response = await client.post(Uri.parse('$endPoint/auth'), [], );
//     switch (response.statusCode) {
//       case 200:
//         var parsed = json.decode(response.body) as List<dynamic>;
//         for (var charger in parsed) {
//           chargers.add(Charger.fromJson(charger));
//         }
//         return chargers;
//       case 500:
//         throw Exception(ErrorCodes.internalError);
//       default:
//         throw Exception(ErrorCodes.internalError);
//     }
//   }
// }

  // The request returns the updated transaction object,
  // If everything goes as expected, it will contain a paymentId.
  Future<Registration> verifyAccount(
    String email,
    String verificationCode,
  ) async {
    var response = await client.post(Uri.parse('$endPoint/auth/verify'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'accept': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          'username': email,
          'code': verificationCode,
        }));

    switch (response.statusCode) {
      case 200:
        var registration = json.decode(response.body);
        var parsedRegistration = Registration.fromJson(registration);
        print("Created account ");
        print(parsedRegistration.toString());

        return parsedRegistration;
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
}
