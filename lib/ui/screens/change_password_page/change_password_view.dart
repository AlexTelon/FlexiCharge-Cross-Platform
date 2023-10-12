import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../theme.dart';
import '../../widgets/top_bar.dart';
import '../../widgets/user_form_input.dart';
import '../../widgets/wide_button.dart';
import 'change_password_viewmodel.dart';

class ChangePasswordView extends StatefulWidget {
  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  String viewTitle = "Change \nPassword";
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChnagePasswordViewModel>.reactive(
        viewModelBuilder: () => ChnagePasswordViewModel(),
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
                                controller: currentPasswordController,
                                labelText: 'Current Password',
                                hint: 'Enter Your Current Password',
                                suffixIcon: Icon(null),
                                validator: null,
                              ),
                              SizedBox(height: 20),
                              UserFormInput(
                                controller: newPasswordController,
                                labelText: 'New Password',
                                hint: 'Enter Your New Password',
                                suffixIcon: Icon(null),
                                validator: null,
                              ),
                              SizedBox(height: 20),
                              UserFormInput(
                                controller: newPasswordController,
                                labelText: 'Repeat Password',
                                hint: 'Enter Your Repeat Password',
                                suffixIcon: Icon(null),
                                validator: null,
                              ),
                              SizedBox(height: 180),
                              WideButton(
                                color: FlexiChargeTheme.green,
                                text: "Save",
                                onTap: () {}, // Display a cupertino alert.
                                showWideButton: true,
                              ),
                              SizedBox(height: 10),
                              TextButton(
                                style: TextButton.styleFrom(
                                    textStyle: const TextStyle(fontSize: 15),
                                    foregroundColor: FlexiChargeTheme.green),
                                onPressed: () {}, // Dispaly a cupertino alert.
                                child: const Text('I forgot my password'),
                              )
                            ]))
                      ],
                    )))));
  }
}
