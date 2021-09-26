import 'package:flexicharge/ui/screens/home_page/home_viewmodel.dart';
import 'package:flexicharge/ui/widgets/text_input.dart';
import 'package:flexicharge/ui/widgets/top_bar.dart';
import 'package:flexicharge/ui/widgets/wide_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:stacked/stacked.dart';

import 'login_viewmodel.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Topbar(
                text: "Log In",
                onTap: () => print("Back to previos page..."),
              ),
              // UPPP
              SizedBox(height: 30),
              Container(
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///Contains the TextInputs
                    Column(
                      children: [
                        TextInputWidget(
                          labelText: 'Email',
                          hint: 'Enter Your Email',
                          onChanged: (value) => print(value),
                        ),
                        SizedBox(height: 10),
                        TextInputWidget(
                          labelText: 'Password',
                          hint: 'Enter Your Password',
                          onChanged: (value) => print(value),
                          isPassword: true,
                        ),
                      ],
                    ),
                    SizedBox(height: 200),

                    ///Contains the WideButton and The InkWell
                    Column(
                      children: [
                        WideButton(
                          text: 'Log in..',
                          showWideButton: true,
                          onTap: () => ('Log in'),
                          color: Color(0xff78bd76),
                        ),
                        SizedBox(height: 30),
                        InkWell(
                          onTap: () => print('Forget Password'),
                          child: Text(
                            'I forget my password',
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
    );
  }
}
