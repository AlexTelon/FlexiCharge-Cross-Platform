import 'package:flexicharge/models/user_input_validator.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../services/user_api_service.dart';

const int VERIFICATION_CODE_LENGTH = 6;

/// The class is a view model for a view that allows a user to reset
/// their password
class RecoverEmailSentViewModel extends BaseViewModel {
  bool _checked = false;
  String _password = "";
  final _userInputValidator = UserInputValidator();

  TextEditingController textController = TextEditingController();
  TextEditingController textControllerPassword = TextEditingController();
  TextEditingController textControllerRepeatPassword = TextEditingController();
  set checked(newState) {
    _checked = newState;
    notifyListeners();
  }

  bool get checked => _checked;

  /// It takes in an email, password, repeat password, and verification code,
  /// and then calls the verifyPasswordReset function in the
  /// UserApiService class
  ///
  /// Args:
  ///   email (String): The email address of the user.
  ///   password (String): The new password for the user.
  ///   repeatPassword (String): This is the password that the user has
  ///   entered in the second text field.verificationCode (String): The code
  ///   that was sent to the user's email.
  Future<void> verifyPassword(String email, String password,
      String repeatPassword, String verificationCode) async {
    try {
      await UserApiService()
          .verifyPasswordReset(email, password, verificationCode);
    } catch (error) {
      print(error);
    }
  }

  /// If the verification code is not null, not empty, and less than 6
  /// characters, return a string that says the verification code needs
  /// to be 6 characters. Otherwise, return null
  ///
  /// Args:
  ///   verificationCode: The verification code that the user entered.
  ///
  /// Returns:
  ///   A String?
  String? validateVerificationCode(verificationCode) {
    if (verificationCode != null &&
        verificationCode.isNotEmpty &&
        verificationCode.length < VERIFICATION_CODE_LENGTH) {
      return 'Verification code needs to be ' +
          VERIFICATION_CODE_LENGTH.toString() +
          ' characters';
    } else {
      return null;
    }
  }

  /// If the password is not null and not empty, check if it's valid. If it's
  /// valid, set the password to the password that was passed in. If it's not
  /// valid, return the first error message. If the password is null
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

  /// If the repeated password is not null, not empty, and not equal to
  /// the password, then return an error message
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
}
