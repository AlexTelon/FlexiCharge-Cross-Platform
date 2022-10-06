import 'dart:async';
import 'package:stacked/stacked.dart';
import '../../../services/user_api_service.dart';

class RegistrationViewmodel extends BaseViewModel {
  bool _checked = false;
  bool _registrationIsValid = false;

  set checked(newState) {
    _checked = newState;
    notifyListeners();
  }

  bool get checked => _checked;

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
}
