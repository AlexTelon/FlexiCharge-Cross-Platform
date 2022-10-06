import 'package:stacked/stacked.dart';

import '../../../models/user_secure_storage.dart';

class ProfileViewModel extends BaseViewModel {
  bool _checked = false;

  set checked(newState) {
    _checked = newState;
    notifyListeners();
  }

  bool get checked => _checked;

  Future<void> logout() async =>
      await UserSecureStorage.deleteUserSecureStorage();
}
