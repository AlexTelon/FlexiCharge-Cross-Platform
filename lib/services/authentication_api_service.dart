import 'dart:convert';
import 'dart:core';

import 'package:flexicharge/enums/error_codes.dart';
import 'package:flexicharge/models/user.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';

enum Status {
  NotLoggedIn,
  LoggedIn,
  Registred,
  NotRegistred,
}

class Authentication {
  static const baseEndPoint = "54.220.194.65:8080/auth";
  static const registerEndPoint = baseEndPoint + '/sign-up';
  static const verifyEndPoint = baseEndPoint + '/verify';
  static const loginEndPoint = baseEndPoint + '/sign-in';
  http.Client client = new http.Client();

  Future<User> registerUser(String name, String familyName, String email,
      String username, String password) async {
    var user = User();
    var response = await client.post(Uri.parse(registerEndPoint));

    switch (response.statusCode) {
      case 200:
        user = json.decode(response.body);
        return user;
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

  Future verifyUser(String code, String username) async {
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
}
