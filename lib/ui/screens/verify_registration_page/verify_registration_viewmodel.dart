import 'dart:convert';

import 'package:flexicharge/enums/error_codes.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flexicharge/services/user_auth_api_service.dart';
import 'package:flexicharge/models/registration.dart';

// ignore: camel_case_types
// enum VERIFICATION_STATUS {
//   LOADING = 0,
//   FINISHED = 1,
//   ERROR = 2
// }

class VerifyRegistrationViewModel extends BaseViewModel {
  var emailController = TextEditingController();
  var verificationController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var errors = "";
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

  Future<void> verifyAccount() async {
    try {
      var result = await apiService.verifyAccount(
          this.emailController.text, this.verificationController.text);
      this.isAccountVerified = true;
      return;
    } catch (error) {
      // error.m
      // print("ERR:");Fruit f = Fruit.values.firstWhere((e) => e.toString() == 'Fruit.' + str);
      var errorString = error.toString().substring(11);
      ErrorCodes errorCode = ErrorCodes.values
          .firstWhere((enumValue) => enumValue.toString() == errorString);

      switch (errorCode) {
        case ErrorCodes.badRequest:
          throw "Invalid verification code.";
        case ErrorCodes.notFound:
          throw "Account could not be created";
        case ErrorCodes.internalError:
          throw "The server could not process your request.";
        default:
          throw "Unknown fault.";
      }
    }
  }

  String get email => this.emailController.text;
  String get verificationCode => this.verificationController.text;
  // bool get isAccountVerified => isAccountVerified;
}
