import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flexicharge/enums/error_codes.dart';

import '../models/user_secure_storage.dart';

/// This class is used to store the User API endpoints for the application
class UserApiService {
  static const String baseURL =
      "http://18.202.253.30:8080"; //Live FlexiCharge API
  http.Client client = new http.Client();

  static final headers = <String, String>{
    'Content-Type': 'application/json',
    'accept': 'application/json',
  };

  static final Uri register = Uri.parse(baseURL + "/auth/sign-up");
  static final Uri login = Uri.parse('$baseURL/auth/sign-in');

  Future<bool> verifyLogin(
    String username,
    String password,
  ) async {
    bool _isValid = false;

    var response = await client.post(
      login,
      headers: headers,
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );
    var jsonDecoded = json.decode(response.body);

    switch (response.statusCode) {
      case 200:
        _isValid = true;
        UserSecureStorage.setUserAccessToken(jsonDecoded['accessToken']);
        UserSecureStorage.getUserAccessToken();
        print("Log in successfull");

        return _isValid;
      case 400:
        throw jsonDecoded['message'];
      case 404:
        throw jsonDecoded['message'];
      case 500:
        throw jsonDecoded['message'];
      default:
        throw Exception("default: " + ErrorCodes.internalError.toString());
    }
  }
}
