import 'package:flexicharge/ui/screens/recover_password_page/recover_password_view.dart';
import 'package:flexicharge/ui/widgets/text_input.dart';
import 'package:flexicharge/ui/widgets/top_bar.dart';
import 'package:flexicharge/ui/widgets/wide_button.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:email_validator/email_validator.dart';

import 'login_viewmodel.dart';

class LoginView extends StatefulWidget {
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String email = "";
  String password = "";
  String errorMsg = "";
  bool _validate = false;
  final _formKey = GlobalKey<FormState>();

  TextEditingController textControllerEmail = TextEditingController();
  TextEditingController textControllerPassword = TextEditingController();

  //test variables
  bool _isChecking = false;
  dynamic _validationMsg;
  final _usernameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: Topbar(
                  text: "Log In",
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
                                controller: textControllerEmail,
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
                                controller: textControllerPassword,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  hintText: 'Enter Your Password',
                                  labelText: 'Password',

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
                      ),

                      ///Contains the WideButton and The InkWell
                      Flexible(
                        flex: 1,
                        child: Column(
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
                                print(email + " " + password);

                                var loginData = await model.validateLogin(
                                    textControllerEmail.text,
                                    textControllerPassword.text);
                                print("loginData in view: " +
                                    loginData.toString());
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

                                print("validation bool:  " +
                                    _validate.toString());

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
