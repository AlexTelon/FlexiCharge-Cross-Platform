import 'dart:async';
import 'package:stacked/stacked.dart';

/// It's a viewmodel class that have boolean property called checked and
/// isValid; as well as a method called
/// validateSetupInvoice. The property isValid is returning true for now but
/// it needs to be implemented where it has to return the API post result.
class SetupInvoicingViewmodel extends BaseViewModel {
  bool _checked = false;
  bool _isValid = false;

  set checked(newState) {
    _checked = newState;
    notifyListeners();
  }

  bool get checked => _checked;

// ValidateSetupInvoice function not fully implemented. _isValid has to be
//assigned API post outcome. If the outcome is success, isValid will be true,
//otherwise false.
  Future<Set> validateSetupInvoice(
      String name, String address, String postcode, String town) async {
    try {
      _isValid = true;
      //await UserInvoiceSetupApiService().verifyInvoiceSetup(name, address, postcode, town);
    } catch (error) {
      var invoiceSetupSuccess = {false, error.toString()};
      return invoiceSetupSuccess;
    }
    var invoiceSetupSuccess = {_isValid, ""};
    return invoiceSetupSuccess;
  }
}
