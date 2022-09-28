import 'package:flexicharge/ui/screens/home_page/home_view.dart';
import 'package:flexicharge/ui/screens/login_page/login_view.dart';
import 'package:flexicharge/ui/screens/registration_page/registration_view.dart';
import 'package:flexicharge/ui/screens/registration_page/registration_viewmodel.dart';
import 'package:flexicharge/ui/screens/setup_invoicing/setup_invoicing_viewmodel.dart';
import 'package:flexicharge/ui/widgets/text_input.dart';
import 'package:flexicharge/ui/widgets/top_bar.dart';
import 'package:flexicharge/ui/widgets/wide_button.dart';
import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

class SetupInvoicingView extends StatelessWidget {
  bool checked = false;
  TextEditingController TemporaryController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SetupInvoicingViewmodel>.reactive(
      viewModelBuilder: () => SetupInvoicingViewmodel(),
      builder: (context, model, child) => Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Topbar(text: "Setup Invoicing"),
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
                          style: TextStyle(
                            fontFamily: 'Lato',
                            color: Color(0xff212121),
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                          ),
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
                          style: TextStyle(
                            fontFamily: 'Lato',
                            color: Color(0xff212121),
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20.0),
                  TextInputWidget(
                    controller: TemporaryController,
                    labelText: 'Name',
                    hint: 'Enter Your Name',
                    onChanged: (value) => print(value),
                  ),
                  SizedBox(height: 20),
                  TextInputWidget(
                    controller: TemporaryController,
                    labelText: 'Adress',
                    hint: 'Enter Your Adress',
                    onChanged: (value) => print(value),
                  ),
                  SizedBox(height: 20),
                  TextInputWidget(
                    controller: TemporaryController,
                    labelText: 'Postcode',
                    hint: 'Enter Your Postcode',
                    onChanged: (value) => print(value),
                    isNumber: true,
                  ),
                  SizedBox(height: 20),
                  TextInputWidget(
                    controller: TemporaryController,
                    labelText: 'Town',
                    hint: 'Enter Your Town',
                    onChanged: (value) => print(value),
                  ),
                  SizedBox(height: 20),
                  WideButton(
                    text: 'Continue',
                    color: Color(0xff78bd76),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegistrationView()),
                      );
                    },
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
                        style: const TextStyle(
                            color: const Color(0xff78bd76),
                            fontWeight: FontWeight.w700,
                            fontFamily: "Lato",
                            fontStyle: FontStyle.normal,
                            fontSize: 13.0),
                        textAlign: TextAlign.center),
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
                            style: TextStyle(
                              fontFamily: 'Lato',
                              color: Color(0xff212121),
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                            ),
                          ))
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

/*
                TextInputWidget(
                    labelText: 'Town',
                    hint: 'Enter Your Town',
                    onChanged: (value) => print(value)),
                WideButton(
                  text: 'Continue',
                  color: Color(0xff78bd76),
                  onTap: () => print(
                      'Line 58, setup_invoicing_view.dart, Register Button'),
                  showWideButton: true,
                ),
                Spacer(),
              ]),
              SizedBox(
                height: 30,
              ),

              Column(
                children: [
                  Text(
                      "If you choose not to invoice, you will be asked to pay each time using Swish",
                      style: const TextStyle(
                          color: Color.fromARGB(255, 43, 47, 43),
                          fontWeight: FontWeight.w500,
                          fontFamily: "Lato",
                          fontStyle: FontStyle.normal,
                          fontSize: 13.0),
                      textAlign: TextAlign.center),
                ],
              ),
              SizedBox(
                height: 30,
              ),

            ],
          ),
        ),
      
      */
