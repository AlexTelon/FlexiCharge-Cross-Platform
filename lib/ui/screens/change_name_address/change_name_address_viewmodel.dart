import 'package:stacked/stacked.dart';

class ChangeNameAddressViewModel extends BaseViewModel {
  late String _name;
  late String _address;
  late String _postcode;
  late String _town;

  void updateName(String name) {
    _name = name;
    notifyListeners();
  }

  void updateAddress(String address) {
    _address = address;
    notifyListeners();
  }

  void updatePostcode(String postcode) {
    _postcode = postcode;
    notifyListeners();
  }

  void updateTown(String town) {
    _town = town;
    notifyListeners();
  }

  void saveChanges() {
    // Right now this function only prints out
    //the inputs from the user. It should
    //instead send a HTTP request to update
    //the user information.
    print("Name:" +
        _name +
        "\nAddress:" +
        _address +
        "\nPostcode:" +
        _postcode +
        "\nTown:" +
        _town);
    // Save the changes
  }
}
