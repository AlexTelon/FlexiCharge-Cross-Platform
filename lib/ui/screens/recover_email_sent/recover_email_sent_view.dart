import 'package:flexicharge/ui/screens/login_page/login_view.dart';
import 'package:flexicharge/ui/screens/recover_email_sent/recover_email_sent_viewmodel.dart';
import 'package:flexicharge/ui/screens/recover_password_page/recover_password_viewmodel.dart';
import 'package:flexicharge/ui/widgets/text_input.dart';
import 'package:flexicharge/ui/widgets/top_bar.dart';
import 'package:flexicharge/ui/widgets/wide_button.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/user_form_input.dart';

// temp dummy data

class Global {
  static var theEmail = RecoverPasswordViewModel().email;
}

class RecoverEmailSentView extends StatelessWidget {
  TextEditingController textController = TextEditingController();
  TextEditingController textControllerPassword = TextEditingController();
  TextEditingController textControllerRepeatPassword = TextEditingController();

  RecoverEmailSentView({Key? key, required this.mail}) : super(key: key);

  final String mail;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RecoverEmailSentViewModel>.reactive(
      viewModelBuilder: () => RecoverEmailSentViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: Topbar(
                  text: "Recover Email Sent",
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Flexible(
                flex: 4,
                child: Container(
                  child: Column(
                    children: [
                      Flexible(
                        flex: 5,
                        child: Column(
                          children: [
                            Text(
                                '''An email with a link to reset your password\n has been sent to the following address...''',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  color: Color(0xff212121),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                )),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 18,
                        child: Column(
                          children: [
                            Text(mail,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  color: Color(0xff212121),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                )),
                            SizedBox(height: 30),
                            UserFormInput(
                              controller: textControllerPassword,
                              isPassword: true,
                              hint: 'Enter New Password',
                              labelText: 'New Password',
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
                            SizedBox(height: 30),
                            UserFormInput(
                              controller: textControllerRepeatPassword,
                              isPassword: true,
                              hint: 'Repeat New Password',
                              labelText: 'Repeat Password',
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
                            SizedBox(height: 30),
                            UserFormInput(
                              controller: textController,
                              isPassword: false,
                              hint: 'Enter Your Verification code',
                              labelText: 'Verification code',
                              validator: (code) {
                                if (code != null && code.length < 5) {
                                  return 'Verification code needs to be 6 characters';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 4,
                        child: WideButton(
                          text: 'Back to Log In',
                          showWideButton: true,
                          onTap: () async {
                            await model.verifyPassword(
                                mail,
                                textControllerPassword.text,
                                textControllerRepeatPassword.text,
                                textController.text);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginView()),
                            );
                          },
                          color: Color(0xff78bd76),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "I didn't get my email :(",
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
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Send Again",
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
