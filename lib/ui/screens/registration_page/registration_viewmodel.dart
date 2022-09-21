import 'dart:async';
import 'dart:convert';

import 'package:flexicharge/enums/userChangeNotifier.dart';
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
    String mobileNumber,
    String password,
    String repeatedPassword,
  ) async {
    print('Register Func');
    print(""" 
    email: $email
    mobile number: $mobileNumber
    password: $password
    repeated password: $repeatedPassword
    """);

    final Map<String, dynamic> registrationData = {
      //change
      "username": "asd",
      "password": "123",
      "email": "email@email.com",
      "name": "asd",
      "family_name": "asd"
    };

    notifyListeners();

    var response = await post(UserApiService.register,
        body: json.encode(registrationData),
        headers: {'Content-Type': 'application/json'});

    print(response.body);
    print(response.statusCode);
  }
}
