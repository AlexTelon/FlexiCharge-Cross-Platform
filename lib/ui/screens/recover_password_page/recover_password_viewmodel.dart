import 'package:stacked/stacked.dart';
import '../../../services/user_api_service.dart';

/// This class is a ViewModel that extends BaseViewModel and has a method
/// that calls a service that sends a reset password email to the user
class RecoverPasswordViewModel extends BaseViewModel {
  bool _checked = false;
  String _email = "";

  set checked(newState) {
    _checked = newState;
    notifyListeners();
  }

  /// It takes an email address as a parameter, and then calls a function in
  /// another class that sends a password reset email to the user
  ///
  /// Args:
  ///   email (String): The email address of the user who wants to reset
  ///   their password.
  Future<void> sendResetPassword(String email) async {
    _email = email;

    try {
      await UserApiService().verifyMailNewPassword(email);
    } catch (error) {
      print(error);
    }
  }

  bool get checked => _checked;
  String get email => _email;
}
