import 'dart:async';
import 'package:flutter/animation.dart';
import 'package:stacked/stacked.dart';
import '../../../services/user_api_service.dart';
import '../../../models/user_input_validator.dart';

class RegistrationViewmodel extends BaseViewModel {
  bool _checked = false;
  bool _registrationIsValid = false;
  String _password = "";

  final _userInputValidator = UserInputValidator();

  set checked(newState) {
    _checked = newState;
    notifyListeners();
  }

  bool get checked => _checked;

  String? validateEmail(email) {
    if (email != null &&
        email.isNotEmpty &&
        !_userInputValidator.emailIsValid(email)) {
      return 'Enter a valid email';
    } else {
      return null;
    }
  }

  String? validatePassword(password) {
    if (password != null && password.isNotEmpty) {
      if (!_userInputValidator.passwordIsValid(password)) {
        return _userInputValidator.passwordErrors.first;
      } else {
        _password = password;
        return null;
      }
    } else {
      return null;
    }
  }

  String? validateRepeatedPassword(repeatedPassword) {
    if (repeatedPassword != null &&
        repeatedPassword.isNotEmpty &&
        !_userInputValidator.passwordsAreEqual(_password, repeatedPassword)) {
      if (_userInputValidator.passwordErrors.isNotEmpty) {
        return 'Password must be valid';
      } else
        return 'Passwords do not match';
    } else {
      return null;
    }
  }

  Future<Set> registerNewUser(
    String email,
    String password,
    String repeatedPassword,
  ) async {
    String errorMessage = "";

    try {
      _registrationIsValid =
          await UserApiService().verifyRegister(email, password);
    } catch (error) {
      errorMessage = error.toString();
      var registerData = {false, errorMessage};
      return registerData;
    }
    var registerData = {_registrationIsValid, errorMessage};
    return registerData;
  }

  Color showButtonColor(email, password, repeatedPassword) {
    if (_checked) {
      return Color(0xff78bd76);
    } else {
      return Color.fromARGB(255, 157, 160, 159);
    }
  }

  bool checkEmail(email) {
    if (email != null &&
        email.isNotEmpty &&
        _userInputValidator.emailIsValid(email)) {
      return true;
    }
    return false;
  }

  bool checkPassword(password) {
    if (password != null &&
        password.isNotEmpty &&
        _userInputValidator.passwordIsValid(password)) {
      return true;
    }
    return false;
  }

  bool checkRepeatPassword(repeatedPassword) {
    if (repeatedPassword != null &&
        repeatedPassword.isNotEmpty &&
        _userInputValidator.passwordsAreEqual(_password, repeatedPassword)) {
      return true;
    }
    return false;
  }
}
