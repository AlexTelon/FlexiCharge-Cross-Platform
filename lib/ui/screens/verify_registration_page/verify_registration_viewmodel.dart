import 'dart:convert';

import 'package:flexicharge/enums/error_codes.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flexicharge/services/user_auth_api_service.dart';
import 'package:flexicharge/models/userVerificationData.dart';

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

  String get email => this.emailController.text;
  String get verificationCode => this.verificationController.text;
  // bool get isAccountVerified => isAccountVerified;
}
