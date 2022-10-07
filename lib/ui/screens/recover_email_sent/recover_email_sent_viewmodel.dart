import 'package:flexicharge/models/user_input_validator.dart';
import 'package:stacked/stacked.dart';
import '../../../services/user_api_service.dart';

const int VERIFICATION_CODE_LENGTH = 6;

class RecoverEmailSentViewModel extends BaseViewModel {
  bool _checked = false;
  String _password = "";
  final _userInputValidator = UserInputValidator();

  set checked(newState) {
    _checked = newState;
    notifyListeners();
  }

  bool get checked => _checked;

  Future<void> verifyPassword(String email, String password,
      String repeatPassword, String verificationCode) async {
    try {
      await UserApiService()
          .verifyPasswordReset(email, password, verificationCode);
    } catch (error) {
      print(error);
    }
  }

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
}
