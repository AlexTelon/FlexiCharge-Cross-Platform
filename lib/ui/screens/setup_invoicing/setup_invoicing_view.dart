import 'package:flexicharge/theme.dart';
import 'package:flexicharge/ui/screens/home_page/home_view.dart';
import 'package:flexicharge/ui/screens/setup_invoicing/setup_invoicing_viewmodel.dart';
import 'package:flexicharge/ui/widgets/text_input.dart';
import 'package:flexicharge/ui/widgets/top_bar.dart';
import 'package:flexicharge/ui/widgets/wide_button.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/error_text.dart';

/// SetupInvoicingView is a stateless widget that contains a scaffold with a
/// single child scroll view that contains a column with a topbar, a sized box,
/// a column with a column with a rich text, a sized box, a column with a
/// rich text, a sized box, a text input widget, a sized box, a text input
/// widget, a sized box, a text input widget, a sized box, a text input widget,
/// a sized box, a wide button, a sized box, an ink well, a sized box,
/// a column with a rich text, a sized box
class SetupInvoicingView extends StatefulWidget {
  @override
  _SetupInvoicingViewState createState() => _SetupInvoicingViewState();
}

class _SetupInvoicingViewState extends State<SetupInvoicingView> {
  final pageTitle = "Setup Invoicing";
  String errorText = "";

  TextEditingController nameController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController postcodeController = new TextEditingController();
  TextEditingController townController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SetupInvoicingViewmodel>.reactive(
      viewModelBuilder: () => SetupInvoicingViewmodel(),
      builder: (context, model, child) => Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Topbar(
                text: pageTitle,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 30),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RichText(
                        softWrap: true,
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text:
                                    'Invoices are the quickest way to start charging \n and manage your payments.'),
                            TextSpan(),
                          ],
                          style: Style.regularText,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RichText(
                        softWrap: true,
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(),
                            TextSpan(
                                text:
                                    'All your charging sessions are collected in a single invoice \n and delivered to you at the end of each month'),
                          ],
                          style: Style.regularText,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20.0),
                  TextInputWidget(
                    controller: nameController,
                    labelText: 'Name',
                    hint: 'Enter Your Name',
                    onChanged: (value) =>
                        print("Line 102 >>>>>> Changed " + value),
                  ),
                  SizedBox(height: 20),
                  TextInputWidget(
                    controller: addressController,
                    labelText: 'Address',
                    hint: 'Enter Your Address',
                    onChanged: (value) => print(value),
                  ),
                  SizedBox(height: 20),
                  TextInputWidget(
                    controller: postcodeController,
                    labelText: 'Postcode',
                    hint: 'Enter Your Postcode',
                    onChanged: (value) => print(value),
                    // isNumber: true,
                  ),
                  SizedBox(height: 20),
                  TextInputWidget(
                    controller: townController,
                    labelText: 'Town',
                    hint: 'Enter Your Town',
                    onChanged: (value) => print(value),
                  ),
                  SizedBox(height: 20),
                  ErrorText(errorMessage: errorText),
                  SizedBox(height: 30),
                  Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 20)),
                  WideButton(
                    text: 'Continue',
                    color: FlexiChargeTheme.lightGrey,
                    onTap:
                        null /*() async {
                      var invoiceData = await model.validateSetupInvoice(
                          nameController.text,
                          addressController.text,
                          postcodeController.text,
                          townController.text);
                      if (invoiceData.elementAt(0)) {
                        setState(() {
                          errorText = invoiceData.elementAt(1);
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeView()),
                        );
                      } else {
                        setState(() {
                          errorText = invoiceData.elementAt(1);
                        });
                      }
                    },*/
                    ,
                    showWideButton: true,
                  ),
                  SizedBox(height: 20.0),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeView()),
                      );
                    },
                    child: Text("No Thanks",
                        style: Style.linkText, textAlign: TextAlign.center),
                  ),
                  SizedBox(height: 10.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RichText(
                        softWrap: true,
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text:
                                    'If you choose not to invoice, \nyou will be asked to pay each time using Swish'),
                            TextSpan()
                          ],
                          style: Style.regularText,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
