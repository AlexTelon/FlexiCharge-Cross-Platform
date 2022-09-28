import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:stacked/stacked.dart';

import '../../../services/user_api_service.dart';

class RegistrationViewmodel extends BaseViewModel {
  bool _checked = false;

  set checked(newState) {
    _checked = newState;
    notifyListeners();
  }

  bool get checked => _checked;

  Future<FutureOr> registerNewUser(
    String email,
    String password,
    String repeatedPassword,
  ) async {
//registrationData according to FlexiCharge API
    final Map<String, dynamic> registrationData = {
      "username": "asdasdasdasdasdasd",
      "password": "Asd123456",
      "email": "email@email.com",
      "name": "asd",
      "family_name": "asd"
    };

    Response response = await post(UserApiService.register,
        body: json.encode(registrationData),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      print(response.body);
      //TODO:
      //1.Save user state and keep the user logged in
      //2. Redirect to "Setup Invoice"
      print("success");
    } else {
      print(response.body);
      //TODO:
      //1. Display error to user
      print("failure");
    }
  }
}
