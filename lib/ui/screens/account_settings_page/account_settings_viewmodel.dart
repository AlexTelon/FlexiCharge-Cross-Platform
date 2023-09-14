import 'package:stacked/stacked.dart';


class AccountSettingsViewModel extends BaseViewModel {

late String _email;
late String _phoneNumber;


void updateEmail(String email) {
  _email = email;
  notifyListeners();
}

void updateMobileNumber(String phoneNumber) {
  _phoneNumber = phoneNumber;
  notifyListeners();
}

}