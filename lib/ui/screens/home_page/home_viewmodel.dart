import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  String title = '';

  void doSomething() {
    title += 'updated ';
    // this will call the builder defined in the view file and rebuild the ui using
    // the update version of the model.
    notifyListeners();
  }
}
