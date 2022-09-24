import 'package:flexicharge/ui/screens/verify_registration_page/verify_registration_viewmodel.dart';
import 'package:flexicharge/ui/widgets/text_input.dart';
import 'package:flexicharge/ui/widgets/top_bar.dart';
import 'package:flexicharge/ui/widgets/wide_button.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class VerifyRegistrationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VerifyRegistrationViewModel>.reactive(
      viewModelBuilder: () => VerifyRegistrationViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: Topbar(
                  text: "Verify Account",
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
                      Flexible(
                        flex: 5,
                        child: Column(
                          children: [
                            TextInputWidget(
                              labelText: 'Email',
                              hint: 'Enter Your Email',
                              onChanged: (value) => {model.email = value},
                            ),
                            SizedBox(height: 30),
                            Text(
                                '''Please provide the email you used to register.\nWe will send you an email.\nWith a link to reset your password''',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  color: Color(0xff212121),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                )),
                            TextInputWidget(
                              labelText: 'Verification Code',
                              hint: 'Enter Your verification code',
                              onChanged: (value) =>
                                  {model.verificationCode = value},
                            ),
                            SizedBox(height: 30),
                            Text(
                                '''Please provide the verification code you got sent to your mail address''',
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
                          onTap: () =>
                              {model.verifyAccount(model.verificationCode)},
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
