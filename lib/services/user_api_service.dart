import 'dart:convert';
import 'package:flexicharge/models/api.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:flexicharge/enums/error_codes.dart';
import 'package:flexicharge/models/user_secure_storage.dart';

//This class is used for:
//    1. Storing User API endpoints.
//    2. Sending requests.
//    3. Verifying and handling responses.

class UserApiService {
  http.Client client = new http.Client();

  static final Uri _register = Uri.parse('${API.url}/auth/sign-up');
  static final Uri _login = Uri.parse('${API.url}/auth/sign-in');
  static final Uri _accountVerification = Uri.parse('${API.url}/auth/verify');
  static final Uri _forgotPassword =
      Uri.parse('${API.url}/auth/forgot-password/');
  static final Uri _passwordReset =
      Uri.parse('${API.url}/auth/confirm-forgot-password');

  static final Exception exeptionMsg =
      Exception("default: " + ErrorCodes.internalError.toString());

  /*
  Most class functions below consist of:
    - A variabel "responseMsg" is the error message that is seen in UI.
    - A null check for response message. Response body is wrapped in null check 
     before decoding the message of the body, otherwise an error will accur.
    - Map data is written according to FlexiCharge API.

  BEWARE: The status code that are handled blow are implemented according 
          to backend. Some responses are not correct and will be changed in 
          the backend, then the frontend must change accordingly.
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
      headers: API.defaultRequestHeaders,
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
        throw jsonDecoded['message'];
      case 404:
        throw jsonDecoded['message'];
      case 500:
        throw jsonDecoded['message'];
      default:
        throw exeptionMsg;
    }
  }

  /// It sends a POST request to the server with the user's email address,
  /// and the server sends an email to the user with a link to reset their
  /// password
  ///
  /// Args:
  ///   email (String): The email address of the user who wants to reset their
  ///   password.
  Future<void> verifyMailNewPassword(
    String email,
  ) async {
    final Uri mailNewPassword = Uri.parse('$_forgotPassword$email');

    String responseMsg = "";
    Response response = await client.post(
      mailNewPassword,
      headers: API.defaultRequestHeaders,
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

  /// It takes in an email, password, and code, and then sends a POST request
  /// to the API with the email,
  /// password, and code as the body
  ///
  /// Args:
  ///   email (String): The email address of the user.
  ///   password (String): The new password for the user.
  ///   code (String): The code sent to the user's email address.
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
      headers: API.defaultRequestHeaders,
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

  /// It takes an email and password, and sends a POST request to the backend
  /// with the email and password as the body
  ///
  /// Args:
  ///   email (String): The email address of the user.
  ///   password (String): The password of the user.
  ///
  /// Returns:
  ///   A Future<bool>
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
      headers: API.defaultRequestHeaders,
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

  /// It takes an email and a verification code, and sends a POST request to the
  /// server with the email and
  /// verification code as the body
  ///
  /// Args:
  ///   email (String): The email address of the user.
  ///   verificationCode (String): The code that was sent to the user's
  ///   email address.
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
      headers: API.defaultRequestHeaders,
      body: json.encode(accountVerificationData),
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
}
