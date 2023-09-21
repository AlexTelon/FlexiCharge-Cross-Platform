import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../models/user_input_validator.dart';

class AccountSettingsViewModel extends BaseViewModel {
  final userInputValidator = UserInputValidator();
  final formKey = GlobalKey<FormState>();

  String? validateEmail(email) {
    if (email != null &&
        email.isNotEmpty &&
        !userInputValidator.emailIsValid(email)) {
      return 'Enter a valid email';
    } else {
      return null;
    }
  }
}
