import 'package:flexicharge/ui/widgets/wide_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../theme.dart';
import '../../widgets/text_input.dart';
import '../../widgets/top_bar.dart';
import 'account_settings_viewmodel.dart';


class AccountSettingsView extends StatelessWidget {
final TextEditingController emailController = TextEditingController();
final TextEditingController mobileNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {

  void _showAlertDialog(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Delete Account'),
        content: const Text('Are you sure you want to delete your Flexicharge user account?'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            /// This parameter indicates this action is the default,
            /// and turns the action's text to bold text.
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          CupertinoDialogAction(
            /// This parameter indicates the action would perform
            /// a destructive action such as deletion, and turns
            /// the action's text color to red.
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

    return ViewModelBuilder<AccountSettingsViewModel>.reactive(viewModelBuilder: () => AccountSettingsViewModel(),
      builder: (context, model, child) => Scaffold(
        body: SingleChildScrollView(
          child: 
          Column(
            children: <Widget>[
            Container(
              child: Topbar(
                text: "Account \nSettings",
                onTap: () { Navigator.pop(context);},
              ),
            ),

            Container(
              padding: EdgeInsets.fromLTRB(0, 40, 0, 30),
              child: TextInputWidget(controller: emailController, labelText: "Email", hint: "Your email", onChanged: (value) => model.updateEmail(value)),
            ),

            Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 25),
            child: TextInputWidget(controller: mobileNumberController, labelText: "Mobile Number", hint: "Your mobile number", onChanged: (value) => model.updateMobileNumber(value)),
            ),

            Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 280),
              child: TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 15),
                  foregroundColor: FlexiChargeTheme.green),
              onPressed: () {},
              child: const Text('Change Password'),
            )),

            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: WideButton(
                color: FlexiChargeTheme.green,
                text: "Update",
                onTap: () {},
                showWideButton: true,
              ),
            ),

            Container(
              child: TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 15),
                  foregroundColor: FlexiChargeTheme.red),
              onPressed: () => _showAlertDialog(context),
              child: const Text('Delete my account'),
            )),
            ],
          ),
        ),
      ),
    );
  }
}