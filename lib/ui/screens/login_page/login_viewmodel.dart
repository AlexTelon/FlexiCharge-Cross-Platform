import 'dart:convert';
import 'package:flexicharge/models/user_secure_storage.dart';
import 'package:stacked/stacked.dart';
import 'package:http/http.dart' as http;
import '../../../services/user_api_service.dart';

/// This class is responsible for validating the user's login credentials
class LoginViewModel extends BaseViewModel {
  bool _isValid = false;

  Future<Set> validateLogin(String username, String password) async {
    var errorMessage = "";

    try {
      _isValid = await UserApiService().verifyLogin(username, password);
    } catch (error) {
      errorMessage = error.toString();
      var loginData = {false, errorMessage};
      return loginData;
    }
    var loginData = {_isValid, errorMessage};
    return loginData;
  }
}
