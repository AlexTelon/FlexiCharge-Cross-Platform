import 'dart:convert';
import 'package:flexicharge/enums/error_codes.dart';
import 'package:flexicharge/models/api.dart';
import 'package:http/http.dart' as http;

/// It takes 4 strings as parameters, and returns a boolean
class UserInvoiceSetupApiService {
  http.Client client = new http.Client();

  /// It takes 4 strings as parameters, and returns a boolean
  /// Returns true if the invoice setup is successful
  ///
  /// Args:
  ///   name (String): String
  ///   address (String): "string"
  ///   postcode (String): "12345"
  ///   town (String): "London"
  ///
  /// Returns:
  ///   The response from the server.
  Future<bool> verifyInvoiceSetup(
    String name,
    String address,
    String postcode,
    String town,
  ) async {
    bool _isValid = false;

    var response = await client.post(
      Uri.parse("${API.url}/invoice-setup"),
      headers: API.defaultRequestHeaders,
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
