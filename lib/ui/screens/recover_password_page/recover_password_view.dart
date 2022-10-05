import 'package:email_validator/email_validator.dart';
import 'package:flexicharge/ui/screens/recover_email_sent/recover_email_sent_view.dart';
import 'package:flexicharge/ui/screens/recover_password_page/recover_password_viewmodel.dart';
import 'package:flexicharge/ui/widgets/text_input.dart';
import 'package:flexicharge/ui/widgets/top_bar.dart';
import 'package:flexicharge/ui/widgets/wide_button.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/user_form_input.dart';

class RecoverPasswordView extends StatefulWidget {
  @override
  State<RecoverPasswordView> createState() => _RecoverPasswordViewState();
}

class _RecoverPasswordViewState extends State<RecoverPasswordView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController textControllerEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RecoverPasswordViewModel>.reactive(
      viewModelBuilder: () => RecoverPasswordViewModel(),
      builder: (context, model, child) => Scaffold(
        body: SingleChildScrollView(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Topbar(
                  text: "Recover Password",
                  onTap: () => Navigator.pop(context),
                ),

                // UPPP
                SizedBox(height: 30),

                Container(
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          UserFormInput(
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
                      SizedBox(height: 150),
                      WideButton(
                        text: 'Send',
                        showWideButton: true,
                        onTap: () async {
                          await model
                              .sendResetPassword(textControllerEmail.text);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RecoverEmailSentView(
                                    mail: textControllerEmail.text)),
                          );
                        },
                        color: Color(0xff78bd76),
                      ),
                      SizedBox(height: 20),
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
