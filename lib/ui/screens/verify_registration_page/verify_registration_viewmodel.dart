import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flexicharge/services/user_auth_api_service.dart';
import 'package:flexicharge/models/registration.dart';

class VerifyRegistrationViewModel extends BaseViewModel {
  var emailController = TextEditingController();
  var verificationController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isAccountVerified = false;
  var apiService = UserApiService();

  // set email(newState) {
  //   print(newState);
  //   _email = newState;
  //   notifyListeners();
  // }

  // set verificationCode(newState) {
  //   print(newState);
  //   _verificationCode = newState;
  //   notifyListeners();
  // }

  void verifyAccount() {
    try {
      String verificationCodeConverted = this.verificationController.text;
      // print(verificationCodeConverted);
      var result = apiService.verifyAccount(
          this.emailController.text, verificationCodeConverted);
      print("Registration succeeded");
      isAccountVerified = true;
    } catch (error) {
      print(error);
      throw "Registration failed";
    }
  }

  String get email => this.emailController.text;
  String get verificationCode => this.verificationController.text;
  // bool get isAccountVerified => isAccountVerified;
}
