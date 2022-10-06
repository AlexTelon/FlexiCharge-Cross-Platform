import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flexicharge/models/user_input_validator.dart';
import 'package:flexicharge/services/user_api_service.dart';

/// This class is responsible for the business logic of the verify registration page
class VerifyRegistrationViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var verificationController = TextEditingController();
  var verificationErrors = "";
  bool isAccountVerified = false;

  final _apiService = UserApiService();
  final _inputValidator = UserInputValidator();

  var _dynamicValidationEmailError = "Enter a valid Email";
  var _dynamicValidationVerificationCodeError = "Enter minimum 6 characters";

  ///Do the verification of a new account.
  Future<void> verifyAccount() async {
    try {
      await _apiService.verifyAccount(
          this.emailController.text, this.verificationController.text);

      this.isAccountVerified = true;

      return;
    } catch (error) {
      throw error;
    }
  }

  /// Velidation of user input.
  String? emailValidator(email) {
    bool validEmail = this._inputValidator.emailIsValid(email);
    return validEmail ? null : this._dynamicValidationEmailError;
  }

  String? verificationCodeValidator(verificationCode) {
    if (verificationCode != null &&
        verificationCode.length < 6 &&
        verificationCode.isNotEmpty) {
      return this._dynamicValidationVerificationCodeError;
    } else {
      return null;
    }
  }
}
