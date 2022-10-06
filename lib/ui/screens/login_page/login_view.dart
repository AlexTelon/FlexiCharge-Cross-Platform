import 'package:flexicharge/ui/screens/recover_password_page/recover_password_view.dart';
import 'package:flexicharge/ui/screens/registration_page/registration_view.dart';
import 'package:flexicharge/ui/widgets/top_bar.dart';
import 'package:flexicharge/ui/widgets/wide_button.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:email_validator/email_validator.dart';
import '../../widgets/error_text.dart';
import '../../widgets/user_form_input.dart';
import '../home_page/home_view.dart';
import 'login_viewmodel.dart';

/// The class is a StatefulWidget that has a form with two text fields and a button. The button calls a
/// function in the ViewModel that validates the input and returns a bool and a string. The bool is used
/// to determine if the form is valid or not and the string is used to display an error message

class LoginView extends StatefulWidget {
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String errorMsg = "";
  bool _validate = false;
  bool _passwordVisible = true;
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
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => RegistrationView()),
                          (Route route) => route.isFirst);
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
                              suffixIcon: Icon(null),
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
                              isPassword: _passwordVisible,
                              hint: 'Enter Your Password',
                              labelText: 'Password',
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
                          ErrorText(errorMessage: errorMsg),
                          Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 20)),
                          WideButton(
                            text: 'Log in',
                            showWideButton: true,
                            onTap: () async {
                              var loginData = await model.validateLogin(
                                  textControllerEmail.text,
                                  textControllerPassword.text);

                              _validate = loginData.elementAt(0);
                              if (!_validate) {
                                setState(() {
                                  errorMsg = loginData.elementAt(1);
                                });
                              } else {
                                setState(() {
                                  errorMsg = "";
                                });
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeView()),
                                );
                              }
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
