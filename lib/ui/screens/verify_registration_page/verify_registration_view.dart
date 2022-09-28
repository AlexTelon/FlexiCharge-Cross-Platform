import 'package:flexicharge/ui/screens/login_page/login_view.dart';
import 'package:flexicharge/ui/screens/verify_registration_page/verify_registration_viewmodel.dart';
import 'package:flexicharge/ui/widgets/text_input.dart';
import 'package:flexicharge/ui/widgets/top_bar.dart';
import 'package:flexicharge/ui/widgets/wide_button.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:email_validator/email_validator.dart';

class VerifyRegistrationView extends StatelessWidget {
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
                  onTap: () => print("Back to previous page..."),
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
                              child: TextFormField(
                                controller: model.emailController,
                                decoration: const InputDecoration(
                                  hintText: 'Enter Your Email',
                                  labelText: 'Email',
                                  border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff292b2b)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff292b2b)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff292b2b)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff292b2b)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                ),
                                validator: (email) {
                                  if (email != null &&
                                      !EmailValidator.validate(email) &&
                                      email.isNotEmpty) {
                                    return 'Enter a valid Email';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            SizedBox(height: 30),
                            FractionallySizedBox(
                              widthFactor: 0.8,
                              child: TextFormField(
                                controller: model.verificationController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  hintText: 'Enter Your verification code',
                                  labelText: 'Verification Code',

                                  border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff292b2b)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff292b2b)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff292b2b)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff292b2b)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  // hint: 'Enter Your Password',
                                  //  onChanged: (value) => print(value),
                                  //  isPassword: true,
                                ),
                                validator: (verificationCode) {
                                  if (verificationCode != null &&
                                      verificationCode.length < 6 &&
                                      verificationCode.isNotEmpty) {
                                    return 'Enter min. 6 characters';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            SizedBox(height: 30.0),
                            WideButton(
                              text: 'Verify Account',
                              color: Color(0xff78bd76),
                              onTap: () => {
                                model.verifyAccount()

                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => LoginView()),
                                // )
                              },
                              showWideButton: true,
                            ),
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
