import 'package:stacked/stacked.dart';
import '../../../services/user_api_service.dart';

/// This class is responsible for validating the user's login credentials
class LoginViewModel extends BaseViewModel {
  bool _isValid = false;

  Future<Set> validateLogin(String username, String password) async {
    var errorMessage = "";

    try {
      _isValid = await UserApiService().verifyLogin(username, password);
    } catch (error) {
      print("ERROR: " + error.toString());
      errorMessage = error.toString();
      var loginData = {false, errorMessage};
      return loginData;
    }
    var loginData = {_isValid, errorMessage};
    return loginData;
  }
}
