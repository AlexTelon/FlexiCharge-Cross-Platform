import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';

//Call this class for validating the user input in register, login and verify registration.
class UserInputValidator extends ChangeNotifier {
  //Password requirments are provided from the database squad.
  var _passwordMinLength = 8;
  var _passwordMinNumberOfInt = 1;
  var _passwordMinNumberOfSpecialChar = 1;
  var _passwordMinNumberOfUppercaseChar = 1;
  var _passwordMinNumberOfLowercaseChar = 1;

  //This array temporarily stores all password error during real time validation.
  //It is called in registration_view to show the first error in array.
  final List<String> passwordErrors = [];

  bool emailIsValid(String email) {
    if (EmailValidator.validate(email)) {
      return true;
    } else
      return false;
  }

  bool passwordIsValid(
    String password,
  ) {
    passwordErrors.clear();
    notifyListeners();

    int numberOfInt = 0;
    int numberOfSpecialChar = 0;
    int numberOfUppercaseChar = 0;
    int numberOfLowercaseChar = 0;

    if (password.length < _passwordMinLength) {
      passwordErrors.add(
          'Must be at least ' + _passwordMinLength.toString() + ' characters');
      notifyListeners();
    }

    //Checking if password requirments are met by comparing code units (ASCII) of each character in password.
    password.codeUnits.forEach((char) {
      if (char > 47 && char < 58) {
        numberOfInt++;
      }

      if (char > 32 && char < 48 ||
          char > 57 && char < 65 ||
          char > 90 && char < 97 ||
          char > 122 && char < 127) {
        numberOfSpecialChar++;
      }

      if (char > 64 && char < 91) {
        numberOfUppercaseChar++;
      }

      if (char > 96 && char < 123) {
        numberOfLowercaseChar++;
      }
    });

    if (numberOfInt < _passwordMinNumberOfInt) {
      passwordErrors.add('Must have at least ' +
          _passwordMinNumberOfInt.toString() +
          ' number');
      notifyListeners();
    }

    if (numberOfSpecialChar < _passwordMinNumberOfSpecialChar) {
      passwordErrors.add('Must have at least ' +
          _passwordMinNumberOfSpecialChar.toString() +
          ' special character');
      notifyListeners();
    }

    if (numberOfUppercaseChar < _passwordMinNumberOfUppercaseChar) {
      passwordErrors.add('Must have at least ' +
          _passwordMinNumberOfUppercaseChar.toString() +
          ' uppercase letter');
      notifyListeners();
    }

    if (numberOfLowercaseChar < _passwordMinNumberOfLowercaseChar) {
      passwordErrors.add('Must have at least ' +
          _passwordMinNumberOfLowercaseChar.toString() +
          ' lowercase letter');
      notifyListeners();
    }

    if (passwordErrors.length > 0) {
      return false;
    } else
      return true;
  }

  bool passwordsAreEqual(String password, String repeatedPassword) {
    if (password == repeatedPassword) {
      return true;
    } else
      return false;
  }
}
