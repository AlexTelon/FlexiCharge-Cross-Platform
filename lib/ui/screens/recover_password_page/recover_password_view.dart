import 'package:email_validator/email_validator.dart';
import 'package:flexicharge/ui/screens/recover_email_sent/recover_email_sent_view.dart';
import 'package:flexicharge/ui/screens/recover_password_page/recover_password_viewmodel.dart';
import 'package:flexicharge/ui/widgets/text_input.dart';
import 'package:flexicharge/ui/widgets/top_bar.dart';
import 'package:flexicharge/ui/widgets/wide_button.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/user_form_input.dart';

class RecoverPasswordView extends StatelessWidget {
  TextEditingController textControllerEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RecoverPasswordViewModel>.reactive(
      viewModelBuilder: () => RecoverPasswordViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: Topbar(
                  text: "Recover Password",
                  onTap: () => Navigator.pop(context),
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
                      Flexible(
                        flex: 5,
                        child: Column(
                          children: [
                            UserFormInput(
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
                            SizedBox(height: 30),
                            Text(
                                '''Please provide the email address you used to register.\nWe will send you an email.\nWith a link to reset your password''',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  color: Color(0xff212121),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                )),
                            // Text('We will send you an email.'),
                            // Text('with a link to reset your password')
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: WideButton(
                          text: 'Send',
                          showWideButton: true,
                          onTap: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RecoverEmailSentView()),
                            )
                          },
                          color: Color(0xff78bd76),
                        ),
                      ),
                      SizedBox(height: 20),
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
