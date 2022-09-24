import 'package:stacked/stacked.dart';
import 'package:flexicharge/services/user_auth_api_service.dart';
import 'package:flexicharge/models/registration.dart';

class VerifyRegistrationViewModel extends BaseViewModel {
  String _email = "";
  String _verificationCode = "";
  bool _isAccountVerified = false;
  var apiService = UserApiService();

  set email(newState) {
    print(newState);
    _email = newState;
    notifyListeners();
  }

  set verificationCode(newState) {
    print(newState);
    _verificationCode = newState;
    notifyListeners();
  }

  void verifyAccount(verificationCode) {
    try {
      String verificationCodeConverted = "$verificationCode";
      print(verificationCodeConverted);
      var result =
          apiService.verifyAccount(this._email, verificationCodeConverted);
      print("Registration succeeded");
      _isAccountVerified = true;
    } catch (error) {
      print(error);
      throw "Registration failed";
    }
  }

  String get email => _email;
  String get verificationCode => _verificationCode;
  bool get isAccountVerified => _isAccountVerified;
}
