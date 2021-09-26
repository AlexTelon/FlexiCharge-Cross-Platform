import 'package:flexicharge/ui/screens/home_page/home_viewmodel.dart';
import 'package:flexicharge/ui/widgets/top_bar.dart';
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
                onTap: () => print("Log In"),
              ),
              // UPPP
              SizedBox(height: 30),
              Container(
                child: Column(
                  children: [
                    FractionallySizedBox(
                      widthFactor: 0.8,
                      child: TextField(
                        onChanged: (t) => print(t),
                        decoration: InputDecoration(
                          hintText: 'Enter Your Email',
                          border: UnderlineInputBorder(),
                          labelText: 'Email',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff292b2b)),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff292b2b)),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    FractionallySizedBox(
                      widthFactor: 0.8,
                      child: TextField(
                        obscureText: true,
                        onChanged: (t) => print(t),
                        decoration: InputDecoration(
                          hintText: 'Enter Your Password',
                          border: UnderlineInputBorder(),
                          labelText: 'Password',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff292b2b)),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff292b2b)),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
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
    );
  }
}
