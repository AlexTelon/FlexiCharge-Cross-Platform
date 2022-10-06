import 'package:stacked/stacked.dart';

import '../../../services/user_api_service.dart';

class RecoverEmailSentViewModel extends BaseViewModel {
  bool _checked = false;

  set checked(newState) {
    _checked = newState;
    notifyListeners();
  }

  Future<void> verifyPassword(String email, String password,
      String repeatPassword, String verificationCode) async {
    if (password == repeatPassword) {
      try {
        await UserApiService()
            .verifyPasswordReset(email, password, verificationCode);
      } catch (error) {
        print(error);
      }
    } else {
      print("not the same passwords");
    }
  }

  bool get checked => _checked;
}
