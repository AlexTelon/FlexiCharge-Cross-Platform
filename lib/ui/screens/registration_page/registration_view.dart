import 'package:flexicharge/ui/screens/registration_page/registration_viewmodel.dart';
import 'package:flexicharge/ui/widgets/text_input.dart';
import 'package:flexicharge/ui/widgets/top_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

class RegistrationView extends StatelessWidget {
  bool checked = false;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegistrationViewmodel>.reactive(
      viewModelBuilder: () => RegistrationViewmodel(),
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Topbar(text: "Register"),
              SizedBox(height: 30),
              SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      TextInputWidget(
                        labelText: 'Email',
                        hint: 'Enter Your Email',
                        onChanged: (value) => print(value),
                      ),
                      SizedBox(height: 10),
                      TextInputWidget(
                        labelText: 'Mobile Number',
                        hint: 'Enter Your Mobile Number',
                        onChanged: (value) => print(value),
                        isNumber: true,
                      ),
                      SizedBox(height: 10),
                      TextInputWidget(
                        labelText: 'Password',
                        hint: 'Enter Your Password',
                        onChanged: (value) => print(value),
                        isPassword: true,
                      ),
                      SizedBox(height: 10),
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
                            decoration: BoxDecoration(),
                            child: Checkbox(
                                value: model.checked,
                                checkColor: Colors.black,
                                activeColor: Colors.white,
                                side: BorderSide(color: Colors.black),
                                onChanged: (newState) =>
                                    model.checked = newState),
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
