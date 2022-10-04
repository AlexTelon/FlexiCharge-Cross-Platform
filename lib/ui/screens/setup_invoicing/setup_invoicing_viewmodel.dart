import 'dart:async';
import 'dart:convert';
import 'package:flexicharge/enums/error_codes.dart';
import 'package:stacked/stacked.dart';

import 'package:http/http.dart' as http;

/// It's a viewmodel class that have boolean property called checked and isValid; as well as a method called
/// validateSetupInvoice. The property isValid is returning true for now but it needs to be implemented where it has to return the API post result.

class SetupInvoicingViewmodel extends BaseViewModel {
  bool _checked = false;
  bool _isValid = false;

  set checked(newState) {
    _checked = newState;
    notifyListeners();
  }

  bool get checked => _checked;

// ValidateSetupInvoice function not fully implemented. _isValid has to be assigned API post outcome. If the outcome is success, isValid will be true, otherwise false.
  Future<Set> validateSetupInvoice(
      String name, String address, String postcode, String town) async {
    try {
      _isValid =
          true; //await UserInvoiceSetupApiService().verifyInvoiceSetup(name, address, postcode, town);
    } catch (error) {
      var invoiceSetupSuccess = {false, error.toString()};
      return invoiceSetupSuccess;
    }
    var invoiceSetupSuccess = {_isValid, ""};
    return invoiceSetupSuccess;
  }
}

class UserInvoiceSetupApiService {
  static const String baseURL =
      "http://18.202.253.30:8080"; //Live FlexiCharge API

  static final Uri createInvoiceSetup = Uri.parse(baseURL + "/invoice-setup");
  http.Client client = new http.Client();
  static final headers = <String, String>{
    'Content-Type': 'application/json',
    'accept': 'application/json',
  };

  Future<bool> verifyInvoiceSetup(
    String name,
    String address,
    String postcode,
    String town,
  ) async {
    bool _isValid = false;

    var response = await client.post(
      createInvoiceSetup,
      headers: headers,
      body: jsonEncode(<String, String>{
        'name': name,
        'address': address,
        'postcode': postcode,
        'town': town,
      }),
    );
    var jsonDecoded = json.decode(response.body);

    switch (response.statusCode) {
      case 200:
        print("Log in successfull");
        _isValid = true;
        return _isValid;
      case 400:
        throw jsonDecoded['message'];
      case 404:
        throw jsonDecoded['message'];
      case 500:
        throw jsonDecoded['message'];
      default:
        throw Exception("default: " + ErrorCodes.internalError.toString());
    }
  }
}
