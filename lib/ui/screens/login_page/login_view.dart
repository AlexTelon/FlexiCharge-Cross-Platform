import 'package:flexicharge/ui/screens/recover_password_page/recover_password_view.dart';
import 'package:flexicharge/ui/screens/registration_page/registration_view.dart';
import 'package:flexicharge/ui/widgets/top_bar.dart';
import 'package:flexicharge/ui/widgets/wide_button.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:email_validator/email_validator.dart';

import '../../widgets/user_form_input.dart';
import 'login_viewmodel.dart';

class LoginView extends StatefulWidget {
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String errorMsg = "";
  bool _validate = false;
  final _formKey = GlobalKey<FormState>();

  TextEditingController textControllerEmail = TextEditingController();
  TextEditingController textControllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, model, child) => Scaffold(
        body: SingleChildScrollView(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Topbar(
                    text: "Log In",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegistrationView()),
                      );
                    }),
                Container(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          FractionallySizedBox(
                            child: UserFormInput(
                              controller: textControllerEmail,
                              isPassword: false,
                              hint: 'Enter Your Email',
                              labelText: 'Email',
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
                            child: UserFormInput(
                              controller: textControllerPassword,
                              isPassword: true,
                              hint: 'Enter Your Password',
                              labelText: 'Password',
                              validator: (password) {
                                if (password != null &&
                                    password.length < 3 &&
                                    password.isNotEmpty) {
                                  return 'Enter min. 3 characters';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            errorMsg,
                            style: TextStyle(color: Colors.red),
                          ),
                          Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 20)),
                          WideButton(
                            text: 'Log in',
                            showWideButton: true,
                            onTap: () async {
                              print("Trying to log in");

                              var loginData = await model.validateLogin(
                                  textControllerEmail.text,
                                  textControllerPassword.text);
                              print(
                                  "loginData in view: " + loginData.toString());
                              print("login contains isValid? : " +
                                  loginData
                                      .contains('errorMessage')
                                      .toString());
                              _validate = loginData.elementAt(0);
                              if (!_validate) {
                                setState(() {
                                  errorMsg = loginData.elementAt(1);
                                });
                              } else {
                                setState(() {
                                  errorMsg = "";
                                });
                              }
                              print(
                                  "validation bool:  " + _validate.toString());

                              final isValidForm =
                                  _formKey.currentState!.validate();
                            },
                            color: Color(0xff78bd76),
                          ),
                          SizedBox(height: 20),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        RecoverPasswordView()),
                              );
                            },
                            child: Text(
                              'I forgot my password',
                              style: TextStyle(
                                fontFamily: 'Lato',
                                color: Color(0xff78bd76),
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
