import 'dart:async';
import 'package:flexicharge/theme.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../services/user_api_service.dart';
import '../../../models/user_input_validator.dart';

/// The class is a viewmodel for a registration page. It has a method that
/// validates the user's input and a method that sends the user's input to
/// the server
class RegistrationViewmodel extends BaseViewModel {
  bool _checked = false;
  bool _registrationIsValid = false;
  String _email = "";
  String _password = "";
  String _repeatedPassword = "";

  final userInputValidator = UserInputValidator();
  final formKey = GlobalKey<FormState>();

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
        !userInputValidator.emailIsValid(email)) {
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
      if (!userInputValidator.passwordIsValid(password)) {
        return userInputValidator.passwordErrors.first;
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
        !userInputValidator.passwordsAreEqual(_password, repeatedPassword)) {
      if (userInputValidator.passwordErrors.isNotEmpty) {
        return 'Password must be valid';
      } else {
        return 'Passwords do not match';
      }
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

  /// If the email, password, and repeated password are all valid, return true, otherwise return false
  ///
  /// Returns:
  ///   A boolean value.
  bool areAllEntriesValid() {
    if (isEmailValid(_email) &&
        isPasswordValid(_password) &&
        isRepeatPasswordValid(_repeatedPassword)) {
      return true;
    } else {
      return false;
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
  bool isEmailValid(email) {
    if (email != null &&
        email.isNotEmpty &&
        userInputValidator.emailIsValid(email)) {
      _email = email;
      return true;
    }
    _email = "";
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
  bool isPasswordValid(password) {
    if (password != null &&
        password.isNotEmpty &&
        userInputValidator.passwordIsValid(password)) {
      _password = password;
      return true;
    }
    _password = "";
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
  bool isRepeatPasswordValid(repeatedPassword) {
    if (repeatedPassword != null &&
        repeatedPassword.isNotEmpty &&
        userInputValidator.passwordsAreEqual(_password, repeatedPassword)) {
      _repeatedPassword = repeatedPassword;
      return true;
    }
    _repeatedPassword = "";
    return false;
  }
}
