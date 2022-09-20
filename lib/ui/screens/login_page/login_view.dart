import 'package:flexicharge/ui/screens/recover_password_page/recover_password_view.dart';
import 'package:flexicharge/ui/widgets/text_input.dart';
import 'package:flexicharge/ui/widgets/top_bar.dart';
import 'package:flexicharge/ui/widgets/wide_button.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'login_viewmodel.dart';

class LoginView extends StatelessWidget {
  String email = "";
  String password = "";
  bool _validate = false;
  TextEditingController textControllerEmail = TextEditingController();
  TextEditingController textControllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Center(
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
                        flex: 3,
                        child: Column(
                          children: [
                            TextInputWidget(
                              controller: textControllerEmail,
                              labelText: 'Email',
                              hint: 'Enter Your Email',
                              onChanged: (value) => print(value),
                            ),
                            SizedBox(height: 30),
                            TextInputWidget(
                              controller: textControllerPassword,
                              labelText: 'Password',
                              hint: 'Enter Your Password',
                              onChanged: (value) => print(value),
                              isPassword: true,
                            ),
                            TextField(
                              decoration: InputDecoration(
                                labelText: '',
                                errorText:
                                    _validate ? 'Value Can\'t Be Empty' : null,
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
                            WideButton(
                              text: 'Log in',
                              showWideButton: true,
                              onTap: () async {
                                print("Trying to log in");
                                print(email + " " + password);
                                await model.login(textControllerEmail.text,
                                    textControllerPassword.text);
                                print("as " + _validate.toString());
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
