import 'package:stacked/stacked.dart';

class SetupInvoicingViewmodel extends BaseViewModel {
  bool _checked = false;

  set checked(newState) {
    _checked = newState;
    notifyListeners();
  }

  bool get checked => _checked;
}
