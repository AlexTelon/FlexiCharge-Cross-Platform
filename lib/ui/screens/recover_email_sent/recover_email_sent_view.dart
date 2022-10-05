import 'package:flexicharge/models/user_input_validator.dart';
import 'package:flexicharge/ui/screens/login_page/login_view.dart';
import 'package:flexicharge/ui/screens/recover_email_sent/recover_email_sent_viewmodel.dart';
import 'package:flexicharge/ui/widgets/top_bar.dart';
import 'package:flexicharge/ui/widgets/wide_button.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../widgets/user_form_input.dart';

/// A class that creates a view when a reset password verification code was sent to the email provided.
/// The email will be displated in this view and the user will have input fields to type in the
/// new password, repeat new password and the verification code. The email, password and verification
/// code will be sent to the provided endpoint to update the existing password.
/// Once reset password was successful the user vill be navigated to teh page

class RecoverEmailSentView extends StatelessWidget {
  String viewTitle = "Recover Email Sent";
  TextEditingController textController = TextEditingController();
  TextEditingController textControllerPassword = TextEditingController();
  TextEditingController textControllerRepeatPassword = TextEditingController();

  RecoverEmailSentView({Key? key, required this.mail}) : super(key: key);
  final String mail;
  final _formKey = GlobalKey<FormState>();
  late String _password;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RecoverEmailSentViewModel>.reactive(
      viewModelBuilder: () => RecoverEmailSentViewModel(),
      builder: (context, model, child) => Scaffold(
        body: SingleChildScrollView(
            child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Topbar(
                      text: viewTitle,
                      onTap: () {},
                    ),
                    SizedBox(height: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            RichText(
                              softWrap: true,
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        '''An email with a link to reset your password\n has been sent to the following address...''',
                                    style: TextStyle(
                                      fontFamily: 'Lato',
                                      color: Color(0xff212121),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.0),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            RichText(
                              softWrap: true,
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(text: mail),
                                ],
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  color: Color(0xff212121),
                                  fontSize: 19,
                                  fontWeight: FontWeight.w900,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.0),
                        UserFormInput(
                          controller: textControllerPassword,
                          isPassword: true,
                          hint: 'Enter New Password',
                          labelText: 'New Password',
                          validator: (password) {
                            final validator = UserInputValidator();
                            if (password != null && password.isNotEmpty) {
                              if (!validator.passwordIsValid(password)) {
                                return validator.passwordErrors.first;
                              } else {
                                _password = password;
                                return null;
                              }
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 10),
                        UserFormInput(
                            controller: textControllerRepeatPassword,
                            isPassword: true,
                            hint: 'Repeat New Password',
                            labelText: 'Repeat Password',
                            validator: (repeatedPassword) {
                              if (repeatedPassword != null &&
                                  repeatedPassword.isNotEmpty) {
                                if (_password != repeatedPassword) {
                                  return 'Fields do not match';
                                }
                              } else {
                                return null;
                              }
                            }),
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
                        SizedBox(height: 20),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              WideButton(
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
                            ]),
                        SizedBox(height: 20.0),
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
                  ],
                ))),
      ),
    );
  }
}
