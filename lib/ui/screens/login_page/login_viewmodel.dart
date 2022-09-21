import 'dart:convert';
import 'package:stacked/stacked.dart';
import 'package:http/http.dart' as http;

class LoginViewModel extends BaseViewModel {
  static const endPoint = "http://18.202.253.30:8080";
  http.Client client = new http.Client();

  Future<Set> validateLogin(String username, String password) async {
    bool _isValid = false;
    var errorMessage = "";

    print("username: " + username);
    print("password: " + password);
    try {
      var response = await client.post(
        Uri.parse('$endPoint/auth/sign-in'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'password': password,
        }),
      );
      var jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print(response.body);
        print("You have been logged in, statudcode: " +
            response.statusCode.toString());
        _isValid = true;
      } else if (response.statusCode == 400) {
        print(errorMessage);
        print(response.body);
        errorMessage = jsonResponse['message'];
        _isValid = false;
      } else {
        print(errorMessage);
        print(response.body);
        errorMessage = jsonResponse['message'];
        _isValid = false;
      }
    } catch (e) {
      print(e);
    }

    var loginData = {_isValid, errorMessage};
    return loginData;
  }
}
