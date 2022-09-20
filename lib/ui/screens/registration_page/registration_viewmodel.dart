import 'package:stacked/stacked.dart';

class RegistrationViewmodel extends BaseViewModel {
  bool _checked = false;

  set checked(newState) {
    _checked = newState;
    notifyListeners();
  }

  bool get checked => _checked;

  void registerNewUser(email, mobileNumber, password, repeatedPassword) {
    print('Register Func');
    print(""" 
    email: $email
    mobile number: $mobileNumber
    password: $password
    repeated password: $repeatedPassword
    """);
  }
}
