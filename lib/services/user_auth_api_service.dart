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

  Future<UserVerificationData> verifyAccount(
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

    var responseJson = json.decode(response.body);
    switch (response.statusCode) {
      case 200:
        var registration = json.decode(response.body);
        var parsedRegistration = UserVerificationData.fromJson(registration);
        return parsedRegistration;
      case 400:
        throw responseJson['message'];
      case 404:
        throw responseJson['message'];
      case 500:
        throw responseJson['message'];
      default:
        throw Exception("default: " + ErrorCodes.internalError.toString());
    }
  }
}
