import 'package:flexicharge/theme.dart';
import 'package:flexicharge/ui/widgets/text_input.dart';
import 'package:flexicharge/ui/widgets/top_bar.dart';
import 'package:flexicharge/ui/widgets/wide_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'change_name_address_viewmodel.dart';

class ChangeNameAddressView extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController postcodeController = TextEditingController();
  final TextEditingController townController = TextEditingController();

  Widget buildTextInput(TextEditingController controller, String labelText,
      String hint, onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextInputWidget(
        controller: controller,
        labelText: labelText,
        hint: hint,
        onChanged: onChanged,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChangeNameAddressViewModel>.reactive(
      viewModelBuilder: () => ChangeNameAddressViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Column(
          children: <Widget>[
            Container(
              child: Topbar(
                text: "Name and Address",
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    buildTextInput(nameController, "Name", "Your name",
                        (String value) => model.updateName(value)),
                    buildTextInput(addressController, "Address", "Your address",
                        (String value) => model.updateAddress(value)),
                    buildTextInput(
                        postcodeController,
                        "Postcode",
                        "Your postcode",
                        (String value) => model.updatePostcode(value)),
                    buildTextInput(townController, "Town", "Your town",
                        (String value) => model.updateTown(value))
                  ],
                ),
              ),
            ),
            WideButton(
              text: 'Update',
              color: FlexiChargeTheme.green,
              onTap: () async {
                model.saveChanges();
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CupertinoAlertDialog(
                      title: const Text("Details Updated"),
                      content: const Text(
                          "Your address has been changed successfully"),
                      actions: <CupertinoDialogAction>[
                        CupertinoDialogAction(
                          child: const Text("Continue"),
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.pop(context);
                          },
                        )
                      ],
                    );
                  },
                );
              },
              showWideButton: true,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 25, 10, 10),
            ),
          ],
        ),
      ),
    );
  }
}
