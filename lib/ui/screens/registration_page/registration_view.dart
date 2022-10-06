import 'package:flexicharge/models/user_input_validator.dart';
import 'package:flexicharge/ui/screens/home_page/home_view.dart';
import 'package:flexicharge/ui/screens/login_page/login_view.dart';
import 'package:flexicharge/ui/screens/registration_page/registration_viewmodel.dart';
import 'package:flexicharge/ui/screens/verify_registration_page/verify_registration_view.dart';
import 'package:flexicharge/ui/widgets/top_bar.dart';
import 'package:flexicharge/ui/widgets/wide_button.dart';
import 'package:flexicharge/ui/widgets/user_form_input.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/error_text.dart';

class RegistrationView extends StatefulWidget {
  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  bool checked = false;
  bool _registrationIsValid = false;

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController repeatPasswordController = new TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final userInputValidator = UserInputValidator();

  late String _password = "";
  late String errorMsg = "";

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegistrationViewmodel>.reactive(
      viewModelBuilder: () => RegistrationViewmodel(),
      builder: (context, model, child) => Scaffold(
        body: SingleChildScrollView(
          child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Topbar(text: "Register"),
                  SizedBox(height: 30),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      UserFormInput(
                        controller: emailController,
                        labelText: 'Email',
                        hint: 'Enter Your Email',
                        validator: (email) {
                          if (email != null &&
                              email.isNotEmpty &&
                              !userInputValidator.emailIsValid(email)) {
                            return 'Enter a valid email';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      UserFormInput(
                        controller: passwordController,
                        labelText: 'Password',
                        hint: 'Enter Your Password',
                        isPassword: true,
                        validator: (password) {
                          if (password != null && password.isNotEmpty) {
                            if (!userInputValidator.passwordIsValid(password)) {
                              return userInputValidator.passwordErrors.first;
                            } else {
                              _password = password;
                              return null;
                            }
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      UserFormInput(
                          controller: repeatPasswordController,
                          labelText: 'Repeat Password',
                          hint: 'Enter Your Repeat Password',
                          isPassword: true,
                          validator: (repeatedPassword) {
                            if (repeatedPassword != null &&
                                repeatedPassword.isNotEmpty &&
                                !userInputValidator.passwordsAreEqual(
                                    _password, repeatedPassword)) {
                              return 'Passwords do not match';
                            } else {
                              return null;
                            }
                          }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 60,
                            decoration: BoxDecoration(),
                            child: Checkbox(
                                value: model.checked,
                                checkColor: Colors.black,
                                activeColor: Colors.white,
                                side: BorderSide(color: Colors.black),
                                onChanged: (newState) =>
                                    model.checked = newState),
                          ),
                          Text(
                            "I agree to the terms and conditions",
                            style: const TextStyle(
                                color: const Color(0xff212121),
                                fontWeight: FontWeight.w400,
                                fontFamily: "Lato",
                                fontStyle: FontStyle.normal,
                                fontSize: 13.0),
                          )
                        ],
                      ),
                      ErrorText(errorMessage: errorMsg),
                      SizedBox(height: 30.0),
                      //TODO: Disable WideButton while input fields are red or the checkbox is not checked.
                      WideButton(
                          showWideButton: true,
                          text: 'Register',
                          color: Color(0xff78bd76),
                          onTap: () async {
                            var registerData = await model.registerNewUser(
                              emailController.text,
                              passwordController.text,
                              repeatPasswordController.text,
                            );

                            _registrationIsValid = registerData.elementAt(0);

                            if (!_registrationIsValid) {
                              setState(() {
                                print(_registrationIsValid);
                                errorMsg = registerData.elementAt(1);
                              });
                            } else {
                              setState(() {
                                errorMsg = "";
                              });

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        VerifyRegistrationView(
                                            password:
                                                this.passwordController.text)),
                              );
                            }
                          }),
                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account? ',
                            style: TextStyle(
                              fontFamily: 'Lato',
                              color: Color(0xff212121),
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginView()),
                              );
                            },
                            child: Text(
                              'Log In',
                              style: TextStyle(
                                fontFamily: 'Lato',
                                color: Color(0xff78bd76),
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomeView()),
                          );
                        },
                        child: Text("Continue as Guest",
                            style: const TextStyle(
                                color: const Color(0xff78bd76),
                                fontWeight: FontWeight.w700,
                                fontFamily: "Lato",
                                fontStyle: FontStyle.normal,
                                fontSize: 13.0),
                            textAlign: TextAlign.center),
                      )
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
