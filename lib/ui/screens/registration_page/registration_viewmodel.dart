import 'package:flexicharge/app/app.locator.dart';
import 'package:flexicharge/services/authentication_api_service.dart';
import 'package:stacked/stacked.dart';

class RegistrationViewmodel extends BaseViewModel {
  bool _checked = false;
  final _authAPI = locator<AuthenticationApiService>();

  String id = '';
  String name = '';
  String familyName = '';
  String email = '';
  String username = '';
  String password = '';
  String confirmPassword = '';
  String accessToken = '';

  set checked(newState) {
    _checked = newState;
    notifyListeners();
  }

  bool get checked => _checked;
}
