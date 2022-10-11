import 'package:flexicharge/ui/screens/login_page/login_view.dart';
import 'package:flexicharge/ui/screens/verify_registration_page/verify_registration_viewmodel.dart';
import 'package:flexicharge/ui/widgets/top_bar.dart';
import 'package:flexicharge/ui/widgets/wide_button.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../widgets/user_form_input.dart';

/// It's a stateful widget that contains a form with two text inputs and a
/// button. The button calls a method in the view model that verifies the
/// user's account
class VerifyRegistrationView extends StatefulWidget {
  final String password;

  const VerifyRegistrationView({super.key, required this.password});
  @override
  State<VerifyRegistrationView> createState() => _VerifyRegistrationViewState();
}

class _VerifyRegistrationViewState extends State<VerifyRegistrationView> {
  String viewTitle = "Verify account";

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VerifyRegistrationViewModel>.reactive(
      viewModelBuilder: () => VerifyRegistrationViewModel(),
      builder: (context, model, child) => Scaffold(
        body: SingleChildScrollView(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: model.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Topbar(
                  text: viewTitle,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///Contains the TextInputs
                    UserFormInput(
                        controller: model.emailController,
                        isPassword: false,
                        hint: 'Enter your Email',
                        labelText: 'Email',
                        suffixIcon: Icon(null),
                        validator: (email) => model.emailValidator(email)),
                    SizedBox(height: 30),
                    UserFormInput(
                        controller: model.verificationController,
                        isPassword: true,
                        suffixIcon: Icon(null),
                        hint: 'Enter the verification code',
                        labelText: 'Verification Code',
                        validator: (verificationCode) =>
                            model.verificationCodeValidator(verificationCode)),
                    SizedBox(height: 30.0),
                    WideButton(
                        showWideButton: true,
                        text: 'Verify Account',
                        color: Color(0xff78bd76),
                        onTap: () async {
                          try {
                            setState(() {
                              model.verificationErrors = "";
                            });
                            await model.verifyAccount();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginView()),
                            );
                          } catch (errors) {
                            setState(() {
                              model.verificationErrors = errors.toString();
                            });
                          }
                        }),
                    SizedBox(height: 30.0),
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
