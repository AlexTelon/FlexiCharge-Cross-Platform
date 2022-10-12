import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flexicharge/ui/screens/home_page/home_view.dart';
import 'package:flexicharge/ui/screens/login_page/login_view.dart';
import 'package:flexicharge/ui/screens/registration_page/registration_viewmodel.dart';
import 'package:flexicharge/ui/screens/verify_registration_page/verify_registration_view.dart';
import 'package:flexicharge/ui/widgets/top_bar.dart';
import 'package:flexicharge/ui/widgets/wide_button.dart';
import 'package:flexicharge/ui/widgets/user_form_input.dart';

import '../../../theme.dart';
import '../../widgets/error_text.dart';

/// I have a form with 3 inputs and a checkbox. When the user clicks the
/// button, the form is validated and if the form is valid, the user is
/// navigated to the next page
class RegistrationView extends StatefulWidget {
  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  String viewTitle = "Register";
  bool _registrationIsValid = false;
  bool _passwordVisible = true;
  late String errorMsg = "";
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController repeatPasswordController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    emailController.addListener(() {
      setState(() {});
    });
    passwordController.addListener(() {
      setState(() {});
    });
    repeatPasswordController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    repeatPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegistrationViewmodel>.reactive(
      viewModelBuilder: () => RegistrationViewmodel(),
      builder: (context, model, child) => Scaffold(
        body: SingleChildScrollView(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: model.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Topbar(text: viewTitle),
                SizedBox(height: 30),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    UserFormInput(
                      controller: emailController,
                      labelText: 'Email',
                      hint: 'Enter Your Email',
                      suffixIcon: Icon(null),
                      validator: (email) {
                        var message = model.validateEmail(email);
                        return message;
                      },
                    ),
                    SizedBox(height: 20),
                    UserFormInput(
                      controller: passwordController,
                      labelText: 'Password',
                      hint: 'Enter Your Password',
                      isPassword: _passwordVisible,
                      suffixIcon: IconButton(
                        icon: Icon(
                          !_passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Color(0xff868686),
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                      validator: (password) {
                        var message = model.validatePassword(password);
                        return message;
                      },
                    ),
                    SizedBox(height: 20),
                    UserFormInput(
                        controller: repeatPasswordController,
                        labelText: 'Repeat Password',
                        hint: 'Enter Your Repeat Password',
                        isPassword: _passwordVisible,
                        suffixIcon: IconButton(
                          icon: Icon(
                            !_passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: FlexiChargeTheme.lightMidGrey,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                        validator: (repeatedPassword) {
                          var message =
                              model.validateRepeatedPassword(repeatedPassword);
                          return message;
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
                    WideButton(
                        showWideButton: true,
                        text: 'Register',
                        color: emailController.text.isNotEmpty &&
                                passwordController.text.isNotEmpty &&
                                repeatPasswordController.text.isNotEmpty &&
                                model.checked
                            ? FlexiChargeTheme.green
                            : FlexiChargeTheme.lightGrey,
                        onTap: () async {
                          if (model.checked && model.areAllEntriesValid()) {
                            var registerData = await model.registerNewUser(
                              emailController.text,
                              passwordController.text,
                              repeatPasswordController.text,
                            );
                            _registrationIsValid = registerData.elementAt(0);
                            if (!_registrationIsValid) {
                              setState(() {
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
                                            password: passwordController.text)),
                              );
                            }
                          } else {
                            setState(() {
                              if (model.isEmailValid(emailController.text) &&
                                  model.isPasswordValid(
                                      passwordController.text) &&
                                  model.isRepeatPasswordValid(
                                      repeatPasswordController.text)) {
                                errorMsg =
                                    "Please accept the terms and conditions!";
                              }
                            });
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
            ),
          ),
        ),
      ),
    );
  }
}
