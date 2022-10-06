import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:flexicharge/enums/error_codes.dart';
import 'package:flexicharge/models/user_secure_storage.dart';
import 'package:flexicharge/models/userVerificationData.dart';

/* This class is used for:
    1. Storing User API endpoints .
    2. Sending requests.
    3. Verifying and handeling responses.
*/

class UserApiService {
  http.Client client = new http.Client();

  ///Live FlexiCharge API from Swagger.
  static const String _baseURL = "http://18.202.253.30:8080";
  static const _headers = <String, String>{
    'Content-Type': 'application/json',
    'accept': 'application/json',
  };

  static final Uri _register = Uri.parse('$_baseURL/auth/sign-up');
  static final Uri _login = Uri.parse('$_baseURL/auth/sign-in');
  static final Uri _accountVerification = Uri.parse('$_baseURL/auth/verify');
  static final Uri _forgotPassword =
      Uri.parse('$_baseURL/auth/forgot-password/');
  static final Uri _passwordReset =
      Uri.parse('$_baseURL/auth/confirm-forgot-password');

  static final Exception exeptionMsg =
      Exception("default: " + ErrorCodes.internalError.toString());

  /*
  Most class functions below consist of:
    -A variabel "responseMsg" is the error message that is seen in UI.
    -A null check for response message. Response body is wrapped in null check before decoding the message of the body, otherwise an error will accur.
    -Map data is written according to FlexiCharge API.

  BEWARE: The status code that are handled blow are implemented according to backend. Some responses are not correct and will be changed in the backend, then the frontend must change accordingly.
  */

  Future<bool> verifyLogin(
    String email,
    String password,
  ) async {
    final Map<String, String> loginData = {
      'username': email,
      'password': password,
    };

    bool _isValid = false;
    Response response = await client.post(
      _login,
      headers: _headers,
      body: jsonEncode(loginData),
    );
    var jsonDecoded = json.decode(response.body);

    switch (response.statusCode) {
      case 200:
        _isValid = true;
        UserSecureStorage.setUserAccessToken(jsonDecoded['accessToken']);
        UserSecureStorage.setUserId(jsonDecoded['user_id']);
        UserSecureStorage.setIsUserLoggedIn(_isValid);
        return _isValid;

      case 400:
        throw json.decode(response.body)['message'];
      case 404:
        throw json.decode(response.body)['message'];
      case 500:
        throw json.decode(response.body)['message'];
      default:
        throw exeptionMsg;
    }
  }

  Future<void> verifyMailNewPassword(
    String email,
  ) async {
    final Uri mailNewPassword = Uri.parse('$_forgotPassword$email');

    String responseMsg = "";
    Response response = await client.post(
      mailNewPassword,
      headers: _headers,
    );

    if (response.body.isNotEmpty) {
      responseMsg = json.decode(response.body)['message'];
    }

    switch (response.statusCode) {
      case 200:
        break;
      case 400:
        throw responseMsg;
      case 404:
        throw responseMsg;
      case 500:
        throw responseMsg;
      default:
        throw exeptionMsg;
    }
  }

  Future<void> verifyPasswordReset(
    String email,
    String password,
    String code,
  ) async {
    final Map<String, dynamic> passwordResetData = {
      'username': email,
      'password': password,
      'confirmationCode': code,
    };

    String responseMsg = "";
    Response response = await client.post(
      _passwordReset,
      headers: _headers,
      body: json.encode(passwordResetData),
    );

    if (response.body.isNotEmpty) {
      responseMsg = json.decode(response.body)['message'];
    }

    switch (response.statusCode) {
      case 200:
        break;
      case 400:
        throw responseMsg;
      case 404:
        throw responseMsg;
      case 500:
        throw responseMsg;
      default:
        throw exeptionMsg;
    }
  }

  Future<bool> verifyRegister(
    String email,
    String password,
  ) async {
    final Map<String, dynamic> registerData = {
      "username": email,
      "password": password,
    };

    String responseMsg = "";
    Response response = await post(
      _register,
      headers: _headers,
      body: json.encode(registerData),
    );

    if (response.body.isNotEmpty) {
      responseMsg = json.decode(response.body)['message'];
    }

    switch (response.statusCode) {
      case 200: //Backend issue: Succeeded registration should be 201.
        return true;
      case 400:
        throw responseMsg;
      case 500:
        throw responseMsg;
      default:
        throw exeptionMsg;
    }
  }

  Future<void> verifyAccount(
    String email,
    String verificationCode,
  ) async {
    final Map<String, dynamic> accountVerificationData = {
      'username': email,
      'code': verificationCode,
    };

    String responseMsg = "";
    Response response = await client.post(
      _accountVerification,
      headers: _headers,
      body: json.encode(accountVerificationData),
    );

    if (response.body.isNotEmpty) {
      responseMsg = json.decode(response.body)['message'];
    }

    switch (response.statusCode) {
      case 200:
        //  var registration = json.decode(response.body);
        // var parsedRegistration = UserVerificationData.fromJson(registration);
        break; // return parsedRegistration;
      case 400:
        throw responseMsg;
      case 404:
        throw responseMsg;
      case 500:
        throw responseMsg;
      default:
        throw exeptionMsg;
    }
  }
}
