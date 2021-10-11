import 'dart:convert';
import 'dart:core';

import 'package:flexicharge/enums/error_codes.dart';
import 'package:flexicharge/models/user_preferences.dart';
import 'package:flexicharge/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

enum UserStatus {
  NotLoggedIn,
  LoggedIn,
  Registred,
  NotRegistred,
}

class AuthenticationApiService {
  static const baseEndPoint = "54.220.194.65:8080/auth";
  static const registerEndPoint = baseEndPoint + '/sign-up';
  static const verifyEndPoint = baseEndPoint + '/verify';
  static const loginEndPoint = baseEndPoint + '/sign-in';
  static const changePasswordEndPoint = baseEndPoint + '/change-password';
  static const resetPasswordEndPoint = baseEndPoint + '/reset-password';
  http.Client client = new http.Client();

  UserStatus _userStatus = UserStatus.NotLoggedIn;

  Future<void> registerUser(String name, String familyName, String email,
      String username, String password) async {
    //var user = User();
    final Map<String, dynamic> registerData = {
      'user': {
        'name': name,
        'family_name': familyName,
        'email': email,
        'username': username,
        'password': password
      }
    };

    Response response = await client.post(Uri.parse(registerEndPoint),
        body: json.encode(registerData),
        headers: {'Content-Type': 'application/json'});

    switch (response.statusCode) {
      case 200:
        _userStatus = UserStatus.Registred;
        break;
      case 400:
        throw Exception("InvalidPasswordException");
      default:
        throw Exception(ErrorCodes.internalError);
    }
  }

  Future<Map<String, dynamic>> loginUser(
      String username, String password) async {
    final Map<String, dynamic> loginData = {
      'user': {'username': username, 'password': password}
    };

    Response response = await client.post(Uri.parse(loginEndPoint),
        body: json.encode(loginData),
        headers: {'Content-Type': 'application/json'});

    switch (response.statusCode) {
      case 200:
        //user = json.decode(response.body);
        final Map<String, dynamic> responseData = json.decode(response.body);
        _userStatus = UserStatus.LoggedIn;
        var userData = responseData['data'];
        User authUser = User.fromJson(userData);
        UserPreferences().saveUser(authUser);
        return responseData;
      case 400:
        throw Exception("NotAuthorizedException");
      default:
        throw Exception(ErrorCodes.internalError);
    }
  }

  Future<void> verifyUser(String code, String username) async {
    final Map<String, dynamic> verifyData = {
      'user': {'username': code, 'password': username}
    };
    Response response = await client.post(Uri.parse(verifyEndPoint),
        body: json.encode(verifyData),
        headers: {'Content-Type': 'application/json'});

    switch (response.statusCode) {
      case 200:
        break;
      case 400:
        throw Exception("ExpiredCodeException");
      default:
        throw Exception(ErrorCodes.internalError);
    }
  }

  Future<void> changePassword(
      String accessToken, String previousPassword, String newPassword) async {
    final Map<String, dynamic> changePasswordData = {
      'data': {
        'accessToken': accessToken,
        'previousPassword': previousPassword,
        'newPassword': newPassword
      }
    };
    Response response = await client.post(Uri.parse(changePasswordEndPoint),
        body: json.encode(changePasswordData),
        headers: {'Content-Type': 'application/json'});

    switch (response.statusCode) {
      case 200:
        break;
      case 400:
        throw Exception("NotAuthorizedException");
      default:
        throw Exception(ErrorCodes.internalError);
    }
  }

  Future<Map<String, dynamic>> resetPassword(String username) async {
    Response response =
        await client.post(Uri.parse('$changePasswordEndPoint/$username'));

    switch (response.statusCode) {
      case 200:
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      case 400:
        throw Exception("CodeDeliveryFailureException");
      default:
        throw Exception(ErrorCodes.internalError);
    }
  }
}
