import 'dart:async';
import 'package:flutter/animation.dart';
import 'package:stacked/stacked.dart';
import '../../../services/user_api_service.dart';
import '../../../models/user_input_validator.dart';

/// The class is a viewmodel for a registration page. It has a method that
/// validates the user's input and a method that sends the user's input to
/// the server
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

  /// If the email is not null, not empty, and not valid, return
  /// 'Enter a valid email', otherwise return null
  ///
  /// Args:
  ///   email: The email address to validate.
  ///
  /// Returns:
  ///   A String?
  String? validateEmail(email) {
    if (email != null &&
        email.isNotEmpty &&
        !_userInputValidator.emailIsValid(email)) {
      return 'Enter a valid email';
    } else {
      return null;
    }
  }

  /// If the password is not null and not empty, check if it's valid. If it's
  /// valid, set the password to the password variable. If it's not valid,
  /// return the first error message. If the password is null
  /// or empty, return null
  ///
  /// Args:
  ///   password: The password to validate.
  ///
  /// Returns:
  ///   A String?
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

  /// If the repeated password is not null, not empty, and not equal to the
  /// password, then return an error message
  ///
  /// Args:
  ///   repeatedPassword: The repeated password that the user entered.
  ///
  /// Returns:
  ///   A string.
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

  /// It takes in an email, password, and repeated password, and returns a
  /// set of a boolean and a string
  ///
  /// Args:
  ///   email (String): String
  ///   password (String): String
  ///   repeatedPassword (String): The password that the user entered in the
  ///   repeated password field.
  ///
  /// Returns:
  ///   A set of two values, a boolean and a string.
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

  /// If the checkbox is checked, return green, else return grey
  ///
  /// Args:
  ///   email: String
  ///   password: the password the user entered
  ///   repeatedPassword: the password that the user has to repeat
  ///
  /// Returns:
  ///   A function that returns a color.
  Color showButtonColor(email, password, repeatedPassword) {
    if (_checked) {
      return Color(0xff78bd76);
    } else {
      return Color.fromARGB(255, 157, 160, 159);
    }
  }

  /// If the email is not null, not empty, and valid, then return true.
  /// Otherwise, return false
  ///
  /// Args:
  ///   email: The email address to check.
  ///
  /// Returns:
  ///   A boolean value.
  bool checkEmail(email) {
    if (email != null &&
        email.isNotEmpty &&
        _userInputValidator.emailIsValid(email)) {
      return true;
    }
    return false;
  }

  /// If the password is not null, not empty, and valid, then return true.
  /// Otherwise, return false
  ///
  /// Args:
  ///   password: The password to be validated.
  ///
  /// Returns:
  ///   A boolean value.
  bool checkPassword(password) {
    if (password != null &&
        password.isNotEmpty &&
        _userInputValidator.passwordIsValid(password)) {
      return true;
    }
    return false;
  }

  /// If the repeated password is not null, not empty, and the passwords are
  /// equal, return true. Otherwise, return false
  ///
  /// Args:
  ///   repeatedPassword: The password that the user has entered in the
  ///   repeated password field.
  ///
  /// Returns:
  ///   A boolean value.
  bool checkRepeatPassword(repeatedPassword) {
    if (repeatedPassword != null &&
        repeatedPassword.isNotEmpty &&
        _userInputValidator.passwordsAreEqual(_password, repeatedPassword)) {
      return true;
    }
    return false;
  }
}
