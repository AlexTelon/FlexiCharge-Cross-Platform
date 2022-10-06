import 'package:stacked/stacked.dart';

import '../../../services/user_api_service.dart';

class RecoverPasswordViewModel extends BaseViewModel {
  bool _checked = false;

  set checked(newState) {
    _checked = newState;
    notifyListeners();
  }

  Future<void> sendResetPassword(String email) async {
    try {
      await UserApiService().verifyMailNewPassword(email);
    } catch (error) {
      print(error);
    }
  }

  bool get checked => _checked;
}
