import 'dart:convert';
import 'package:flexicharge/models/user_secure_storage.dart';
import 'package:stacked/stacked.dart';
import 'package:http/http.dart' as http;

import '../../../services/user_api_service.dart';

class LoginViewModel extends BaseViewModel {
  // static const endPoint = "http://18.202.253.30:8080";
  // http.Client client = new http.Client();
  bool _isValid = false;

  Future<Set> validateLogin(String username, String password) async {
    var errorMessage = "";

    try {
      _isValid = await UserApiService().verifyLogin(username, password);
    } catch (error) {
      print("------------------");
      print("error e: " + error.toString());
      print("------------------");
      errorMessage = error.toString();
      var loginData = {_isValid, errorMessage};
      return loginData;
    }
    var loginData = {_isValid, errorMessage};
    return loginData;
  }
}
/*
Future<Set> validateLogin(String username, String password) async {
    bool _isValid = false;
    var errorMessage = "";

    try {
      var response = await client.post(
        UserApiService.login,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'password': password,
        }),
      );
      var jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print(response.body);
        print("You have been logged in, statudcode: " +
            response.statusCode.toString());
        _isValid = true;
        UserSecureStorage.setUserAccessToken(jsonResponse['accessToken']);
        UserSecureStorage.getUserAccessToken();
      } else if (response.statusCode == 400) {
        print(errorMessage);
        print(response.body);
        errorMessage = jsonResponse['message'];
        _isValid = false;
      } else {
        print(errorMessage);
        print(response.body);
        errorMessage = jsonResponse['message'];
        _isValid = false;
      }
    } catch (e) {
      print(e);
    }

    var loginData = {_isValid, errorMessage};
    return loginData;
  }*/