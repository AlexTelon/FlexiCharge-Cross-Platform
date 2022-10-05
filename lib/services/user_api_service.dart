import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flexicharge/enums/error_codes.dart';
import 'package:http/http.dart';
import '../models/user_secure_storage.dart';
import 'package:flexicharge/models/userVerificationData.dart';

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
  // static final Uri forgotPassword = Uri.parse('$baseURL/auth/forgot-password');

  /// It takes a username and password, sends a POST request to the server, and returns a boolean value
  /// based on the response
  ///
  /// Args:
  ///   username (String): The username of the user
  ///   password (String): "123456"
  ///
  /// Returns:
  ///   A Future<bool>
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
        print("Log in successfull");
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
        throw Exception("default: " + ErrorCodes.internalError.toString());
    }
  }

  Future<void> sendNewPassword(
    String email,
  ) async {
    print("inne i user api");
    var response = await client.post(
      Uri.parse('$baseURL/auth/forgot-password/$email'),
      headers: headers,
    );
    var jsonDecoded = json.decode(response.body);

    switch (response.statusCode) {
      case 200:
        print("Email with verification code is successfully sent");
        print("jsonDecode: " + jsonDecoded.toString());
        break;
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

  Future<void> verifyPasswordReset(
    String email,
    String password,
    String code,
  ) async {
    var response =
        await client.post(Uri.parse('$baseURL/auth/confirm-forgot-password'),
            headers: headers,
            body: jsonEncode(<String, String>{
              'username': email,
              'password': password,
              'confirmationCode': code,
            }));

    var jsonDecoded = json.decode(response.body);
    print("jsonDecode: " + jsonDecoded.toString());
    switch (response.statusCode) {
      case 200:
        print("new password sent");
        break;
      case 400:
        throw jsonDecoded['message'];
      case 404:
        throw jsonDecoded['message'];
      case 500:
        throw jsonDecoded['message'];
        
  Future<bool> verifyRegister(
    String email,
    String password,
  ) async {
    //Message that is seen in UI.
    String responseMsg = "";

    //registrationData according to FlexiCharge API
    final Map<String, dynamic> registrationData = {
      "username": email,
      "password": password,
    };

    Response response = await post(UserApiService.register,
        body: json.encode(registrationData),
        headers: {'Content-Type': 'application/json'});

    /// Checking if the response body is empty before decoding. Otherwise, an error accurs.
    if (response.body.isNotEmpty) {
      responseMsg = json.decode(response.body)['message'];
    }

    switch (response.statusCode) {
      case 200:
        print("Log in successfull");
        return true;
      case 400:
        print(responseMsg);
        throw responseMsg;
      case 500:
        throw responseMsg;
      default:
        throw Exception("default: " + ErrorCodes.internalError.toString());
    }
  }

  Future<UserVerificationData> verifyAccount(
    String email,
    String verificationCode,
  ) async {
    var response = await client.post(Uri.parse('$baseURL/auth/verify'),
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
