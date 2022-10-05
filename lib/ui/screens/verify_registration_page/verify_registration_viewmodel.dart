import 'dart:convert';

import 'package:flexicharge/enums/error_codes.dart';
import 'package:flexicharge/models/user_input_validator.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flexicharge/services/user_api_service.dart';
import 'package:flexicharge/models/registration.dart';
import 'package:email_validator/email_validator.dart';

// ignore: camel_case_types
// enum VERIFICATION_STATUS {
//   LOADING = 0,
//   FINISHED = 1,
//   ERROR = 2
// }

/// This class is responsible for the business logic of the verify registration page
class VerifyRegistrationViewModel extends BaseViewModel {
  var emailController = TextEditingController();
  var verificationController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final inputValidator = UserInputValidator();

  var dynamicValidationEmailError = "Enter a valid Email";
  var dynamicValidationVerificationCodeError = "Enter minimum 6 characters";

  var errors = "";
  bool isAccountVerified = false;
  var apiService = UserApiService();

  Future<void> verifyAccount() async {
    try {
      var result = await apiService.verifyAccount(
          this.emailController.text, this.verificationController.text);
      this.isAccountVerified = true;
      return;
    } catch (error) {
      throw error;
    }
  }

  Future<void> login(String password) async {
    try {
      apiService.verifyLogin(this.emailController.text, password);
    } catch (error) {
      throw error;
    }
  }

  String? emailValidator(email) {
    bool validEmail = this.inputValidator.emailIsValid(email);
    return validEmail ? null : this.dynamicValidationEmailError;
  }

  String? verificationCodeValidator(verificationCode) {
    if (verificationCode != null &&
        verificationCode.length < 6 &&
        verificationCode.isNotEmpty) {
      return this.dynamicValidationVerificationCodeError;
    } else {
      return null;
    }
  }

  String get email => this.emailController.text;
  String get verificationCode => this.verificationController.text;
  // bool get isAccountVerified => isAccountVerified;
}
