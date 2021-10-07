import 'dart:convert';
import 'dart:core';

import 'package:flexicharge/enums/error_codes.dart';
import 'package:flexicharge/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

enum Status {
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
  http.Client client = new http.Client();

  Future<void> registerUser(String name, String familyName, String email,
      String username, String password) async {
    //var user = User();
    final Map<String, dynamic> registerData = {
      'user': {
        'name' : name,
        'family_name' :familyName,
        'email': email, 
        'username' : username,
        'password': password
        }
    };

    Response response = await client.post(
      Uri.parse(registerEndPoint),
      body: json.encode(registerData),
      headers: {'Content-Type': 'application/json'}
      );

    switch (response.statusCode) {
      case 200:
        //user = json.decode(response.body);
        //return user;
        break;
      case 400:
        throw Exception("InvalidPasswordException");
      default:
        throw Exception(ErrorCodes.internalError);
    }
  }

  Future<Map<String, dynamic>> loginUser(
      String username, String password) async {
    //var user = User();
    var response = await client.post(Uri.parse(loginEndPoint));

    switch (response.statusCode) {
      case 200:
        //user = json.decode(response.body);
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      case 400:
        throw Exception("InvalidPasswordException");
      default:
        throw Exception(ErrorCodes.internalError);
    }
  }

  Future<void> verifyUser(String code, String username) async {
    var response = await client.post(Uri.parse(verifyEndPoint));

    switch (response.statusCode) {
      case 200:
        break;
      case 400:
        throw Exception("InvalidPasswordException");
      default:
        throw Exception(ErrorCodes.internalError);
    }
  }

  Future<Map<String, dynamic>> resetPassword(
      String accessToken, String previousPassword, String newPassword) async {
    var response = await client.post(Uri.parse(verifyEndPoint));

    switch (response.statusCode) {
      case 200:
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      case 400:
        throw Exception("InvalidPasswordException");
      default:
        throw Exception(ErrorCodes.internalError);
    }
  }
}
