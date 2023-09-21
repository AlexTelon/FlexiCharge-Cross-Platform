import 'package:flexicharge/ui/screens/change_password_page/change_password_view.dart';
import 'package:flexicharge/ui/widgets/wide_button.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../theme.dart';
import '../../widgets/top_bar.dart';
import '../../widgets/user_form_input.dart';
import 'account_settings_viewmodel.dart';

class AccountSettingsView extends StatefulWidget {
  @override
  State<AccountSettingsView> createState() => _AccountSettingsViewState();
}

class _AccountSettingsViewState extends State<AccountSettingsView> {
  String viewTitle = "Account \nSettings";
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    mobileNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AccountSettingsViewModel>.reactive(
      viewModelBuilder: () => AccountSettingsViewModel(),
      builder: (context, model, child) => Scaffold(
          body: SingleChildScrollView(
              child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: model.formKey,
                  child: Column(
                    children: [
                      Topbar(
                        text: viewTitle,
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      Container(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 30),
                              UserFormInput(
                                controller: emailController,
                                labelText: 'Email',
                                hint: 'Enter Your Email',
                                suffixIcon: Icon(null),
                                validator: (email) {
                                  email = email!;
                                  var message = model.validateEmail(email);
                                  return message;
                                },
                              ),
                              SizedBox(height: 20),
                              UserFormInput(
                                controller: mobileNumberController,
                                labelText: 'Mobile Number',
                                hint: 'Enter Your Mobile Number',
                                suffixIcon: Icon(null),
                                validator:
                                    null, // Check if the mobile number is valid!
                              ),
                              SizedBox(height: 20),
                              TextButton(
                                style: TextButton.styleFrom(
                                    textStyle: const TextStyle(fontSize: 15),
                                    foregroundColor: FlexiChargeTheme.green),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ChangePasswordView(),
                                    ),
                                  );
                                },
                                child: const Text('Change Password'),
                              ),
                              SizedBox(height: 250),
                              WideButton(
                                color: FlexiChargeTheme.green,
                                text: "Update",
                                onTap: () {}, // Display a cupertino alert.
                                showWideButton: true,
                              ),
                              SizedBox(height: 10),
                              TextButton(
                                style: TextButton.styleFrom(
                                    textStyle: const TextStyle(fontSize: 15),
                                    foregroundColor: FlexiChargeTheme.red),
                                onPressed: () {}, // Display a cupertino alert.
                                child: const Text('Delete my account'),
                              )
                            ]),
                      ),
                    ],
                  )))),
    );
  }
}
