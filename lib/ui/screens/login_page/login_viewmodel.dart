import 'dart:convert';
import 'package:stacked/stacked.dart';
import 'package:http/http.dart' as http;

class LoginViewModel extends BaseViewModel {
  static const endPoint = "http://18.202.253.30:8080";
  http.Client client = new http.Client();

  Future<void> login(String username, String password) async {
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
        print("You have been logged in, statudcode: " +
            response.statusCode.toString());
      } else if (response.statusCode == 400) {
        var errorMessage = jsonResponse['message'];
        print(errorMessage);
      } else {
        print(response.body);
      }
    } catch (e) {
      print(e);
    }
  }
}
