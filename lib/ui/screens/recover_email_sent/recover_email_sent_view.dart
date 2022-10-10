import 'package:flexicharge/ui/screens/login_page/login_view.dart';
import 'package:flexicharge/ui/screens/recover_email_sent/recover_email_sent_viewmodel.dart';
import 'package:flexicharge/ui/widgets/top_bar.dart';
import 'package:flexicharge/ui/widgets/wide_button.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../widgets/user_form_input.dart';

/// A class that creates a view when a reset password verification code was sent to the email provided.
/// The email will be displayed in this view and the user will have input fields to type in the
/// new password, repeat new password and the verification code. The email, password and verification
/// code will be sent to the provided endpoint to update the existing password.
/// Once reset password was successful the user will be navigated to teh page
class RecoverEmailSentView extends StatefulWidget {
  RecoverEmailSentView({Key? key, required this.mail}) : super(key: key);
  final String mail;

  @override
  State<RecoverEmailSentView> createState() => _RecoverEmailSentViewState();
}

class _RecoverEmailSentViewState extends State<RecoverEmailSentView> {
  String viewTitle = "Recover Email Sent";
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = true;

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
                                    '''An email with a verification code to reset your password\n has been sent to the following address...''',
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
                    SizedBox(height: 10.0),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        RichText(
                          softWrap: true,
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(text: widget.mail),
                            ],
                            style: TextStyle(
                              fontFamily: 'Lato',
                              color: Color(0xff212121),
                              fontSize: 19,
                              fontWeight: FontWeight.w800,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    UserFormInput(
                      controller: model.textController,
                      isPassword: false,
                      suffixIcon: Icon(null),
                      hint: 'Enter Your Verification code',
                      labelText: 'Verification code',
                      validator: (verificationCode) {
                        var message =
                            model.validateVerificationCode(verificationCode);
                        return message;
                      },
                    ),
                    SizedBox(height: 30),
                    UserFormInput(
                      controller: model.textControllerPassword,
                      isPassword: _passwordVisible,
                      hint: 'Enter New Password',
                      labelText: 'New Password',
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
                    SizedBox(height: 10),
                    UserFormInput(
                        controller: model.textControllerRepeatPassword,
                        isPassword: _passwordVisible,
                        hint: 'Repeat New Password',
                        labelText: 'Repeat Password',
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
                        validator: (repeatedPassword) {
                          var message =
                              model.validateRepeatedPassword(repeatedPassword);
                          return message;
                        }),
                    SizedBox(height: 30),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          WideButton(
                            text: 'Back to Log In',
                            showWideButton: true,
                            onTap: () async {
                              await model.verifyPassword(
                                  widget.mail,
                                  model.textControllerPassword.text,
                                  model.textControllerRepeatPassword.text,
                                  model.textController.text);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginView()),
                              );
                            },
                            color: Color(0xff78bd76),
                          ),
                        ]),
                    SizedBox(height: 10.0),
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
            ),
          ),
        ),
      ),
    );
  }
}
