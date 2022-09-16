import 'package:flexicharge/ui/screens/home_page/home_view.dart';
import 'package:flexicharge/ui/screens/login_page/login_view.dart';
import 'package:flexicharge/ui/screens/registration_page/registration_viewmodel.dart';
import 'package:flexicharge/ui/widgets/text_input.dart';
import 'package:flexicharge/ui/widgets/top_bar.dart';
import 'package:flexicharge/ui/widgets/wide_button.dart';
import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

class RegistrationView extends StatelessWidget {
  bool checked = false;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegistrationViewmodel>.reactive(
      viewModelBuilder: () => RegistrationViewmodel(),
      builder: (context, model, child) => Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Topbar(text: "Register"),
              SizedBox(height: 30),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // SizedBox(height: 1),
                  TextInputWidget(
                    labelText: 'Email',
                    hint: 'Enter Your Email',
                    onChanged: (value) => print(value),
                  ),
                  SizedBox(height: 20),
                  TextInputWidget(
                    labelText: 'Mobile Number',
                    hint: 'Enter Your Mobile Number',
                    onChanged: (value) => print(value),
                    isNumber: true,
                  ),
                  SizedBox(height: 20),
                  TextInputWidget(
                    labelText: 'Password',
                    hint: 'Enter Your Password',
                    onChanged: (value) => print(value),
                    isPassword: true,
                  ),
                  SizedBox(height: 20),
                  TextInputWidget(
                    labelText: 'Repeat Password',
                    hint: 'Enter Your Repeat Password',
                    onChanged: (value) => print(value),
                    isPassword: true,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 60,
                        decoration: BoxDecoration(),
                        child: Checkbox(
                            value: model.checked,
                            checkColor: Colors.black,
                            activeColor: Colors.white,
                            side: BorderSide(color: Colors.black),
                            onChanged: (newState) => model.checked = newState),
                      ),
                      Text(
                        "I agree to the terms and conditions",
                        style: const TextStyle(
                            color: const Color(0xff212121),
                            fontWeight: FontWeight.w400,
                            fontFamily: "Lato",
                            fontStyle: FontStyle.normal,
                            fontSize: 13.0),
                      )
                    ],
                  ),
                  SizedBox(height: 30.0),
                  WideButton(
                    text: 'Register',
                    color: Color(0xff78bd76),
                    onTap: () => print('Register Button'),
                    showWideButton: true,
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginView()),
                          );
                        },
                        child: Text(
                          'Log In',
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
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeView()),
                      );
                    },
                    child: Text("Continue as Guest",
                        style: const TextStyle(
                            color: const Color(0xff78bd76),
                            fontWeight: FontWeight.w700,
                            fontFamily: "Lato",
                            fontStyle: FontStyle.normal,
                            fontSize: 13.0),
                        textAlign: TextAlign.center),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
