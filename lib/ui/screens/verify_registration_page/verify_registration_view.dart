import 'dart:convert';

import 'package:flexicharge/ui/screens/login_page/login_view.dart';
import 'package:flexicharge/ui/screens/profile_settings_page/profile_settings_view.dart';
import 'package:flexicharge/ui/screens/verify_registration_page/verify_registration_viewmodel.dart';
import 'package:flexicharge/ui/widgets/text_input.dart';
import 'package:flexicharge/ui/widgets/top_bar.dart';
import 'package:flexicharge/ui/widgets/wide_button.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../../widgets/error_text.dart';
import '../../widgets/user_form_input.dart';

class VerifyRegistrationView extends StatefulWidget {
  @override
  State<VerifyRegistrationView> createState() => _VerifyRegistrationViewState();
}

class _VerifyRegistrationViewState extends State<VerifyRegistrationView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VerifyRegistrationViewModel>.reactive(
      viewModelBuilder: () => VerifyRegistrationViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: model.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: Topbar(
                  text: "Verify account",
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              // UPPP
              // SizedBox(height: 30),
              Flexible(
                flex: 4,
                child: Container(
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///Contains the TextInputs
                      Flexible(
                        flex: 2,
                        child: Column(
                          children: [
                            FractionallySizedBox(
                              widthFactor: 0.8,
                              child: UserFormInput(
                                  controller: model.emailController,
                                  isPassword: false,
                                  hint: 'Enter your Email',
                                  labelText: 'Email',
                                  suffixIcon: Icon(null),
                                  validator: (email) =>
                                      model.emailValidator(email)),
                            ),
                            SizedBox(height: 30),
                            FractionallySizedBox(
                              widthFactor: 0.8,
                              child: UserFormInput(
                                  controller: model.verificationController,
                                  isPassword: true,
                                  suffixIcon: Icon(null),
                                  hint: 'Enter the verification code',
                                  labelText: 'Verification Code',
                                  validator: (verificationCode) =>
                                      model.verificationCodeValidator(
                                          verificationCode)),
                            ),
                            SizedBox(height: 30.0),
                            WideButton(
                                showWideButton: true,
                                text: 'Verify Account',
                                color: Color(0xff78bd76),
                                onTap: () async {
                                  try {
                                    setState(() {
                                      model.errors = "";
                                    });

                                    await model.verifyAccount();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProfileView()),
                                    );
                                  } catch (errors) {
                                    setState(() {
                                      model.errors = errors.toString();
                                    });
                                  }
                                }),

                            if (!model.isAccountVerified &&
                                model.errors.isNotEmpty)
                              ErrorText(errorMessage: model.errors),

                            // Text(model.errors.toString())
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
