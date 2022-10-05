import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flexicharge/models/user_input_validator.dart';
import 'package:flexicharge/services/user_api_service.dart';

/// This class is responsible for the business logic of the verify registration page
class VerifyRegistrationViewModel extends BaseViewModel {
  var emailController = TextEditingController();
  var verificationController = TextEditingController();
  var dynamicValidationEmailError = "Enter a valid Email";
  var dynamicValidationVerificationCodeError = "Enter minimum 6 characters";

  final formKey = GlobalKey<FormState>();
  final inputValidator = UserInputValidator();

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
}
