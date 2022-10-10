import 'package:stacked/stacked.dart';

import '../../../models/user_secure_storage.dart';

/// The ProfileViewModel class extends the BaseViewModel class and has a
/// boolean property called checked. It also has a method called logout which
/// deletes the user's secure storage
class ProfileViewModel extends BaseViewModel {
  bool _checked = false;

  set checked(newState) {
    _checked = newState;
    notifyListeners();
  }

  bool get checked => _checked;

  /// It deletes the user's secure storage
  Future<void> logout() async =>
      await UserSecureStorage.deleteUserSecureStorage();
}
