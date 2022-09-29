//Call this class for validating the user input in register, login, verify registration etc.
import 'dart:async';
import 'dart:developer';

class UserInputValidator {
//Declare bools and error messages here
//Declare validation functions here

  //Private password requirments
  var _passwordMinLength = 8;
  var _passwordMinNumberOfInt = 1;
  var _passwordMinNumberOfSpecialChar = 1;
  var _passwordMinNumberOfUppercaseChar = 1;
  var _passwordMinNumberOfLowercaseChar = 1;

  late bool emailIsValid;

  late bool passwordInputsAreEqual;
  late var passwordErrors = <String>[];

  Future<FutureOr> emailValidation(
    String password,
    String repeatedPassword,
  ) async {}

  bool passwordIsValid(
    String password,
  ) {
    passwordErrors.clear();

    if (password.length <= _passwordMinLength) {
      passwordErrors.add(
          'Must be at least' + _passwordMinLength.toString() + 'characters');
    }

    int numberOfInt = 0;
    int numberOfSpecialChar = 0;
    int numberOfUppercaseChar = 0;
    int numberOfLowercaseChar = 0;

    password.codeUnits.forEach((char) {
      if (char < 58 && char > 47) {
        numberOfInt++;
      }

      if (char < 48 && char > 23 ||
          char < 97 && char > 90 ||
          char < 127 && char > 122) {
        numberOfSpecialChar++;
      }

      if (char < 91 && char > 64) {
        numberOfUppercaseChar++;
      }

      if (char < 123 && char > 96) {
        numberOfLowercaseChar++;
      }
    });

    if (numberOfInt < _passwordMinNumberOfInt) {
      passwordErrors.add(
          'Must have at least' + _passwordMinNumberOfInt.toString() + 'number');
    }

    if (numberOfSpecialChar < _passwordMinNumberOfSpecialChar) {
      passwordErrors.add('Must have at least' +
          _passwordMinNumberOfSpecialChar.toString() +
          'special character');
    }

    if (numberOfUppercaseChar < _passwordMinNumberOfUppercaseChar) {
      passwordErrors.add('Must have at least' +
          _passwordMinNumberOfUppercaseChar.toString() +
          'uppercase letter');
    }

    if (numberOfLowercaseChar < _passwordMinNumberOfLowercaseChar) {
      passwordErrors.add('Must have at least' +
          _passwordMinNumberOfLowercaseChar.toString() +
          'lowercase letter');
    }

    if (passwordErrors.length > 0) {
      log(passwordErrors.first);
      return false;
    } else
      return true;
  }
}
