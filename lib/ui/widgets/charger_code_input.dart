import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

/// I'm using a package called pin_code_text_field to create a text field that only accepts numbers and
/// has a max length of 6
class ChargerCodeInput extends StatelessWidget {
  const ChargerCodeInput({
    required this.onChanged,
    required this.validator,
    required this.controller,
    Key? key,
  }) : super(key: key);
  final Function(String) onChanged;
  final String Function(String?)? validator;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PinCodeTextField(
        controller: controller,
        onChanged: onChanged,
        onCompleted: validator,
        // validator: validator, // Essa skrivit
        appContext: context,
        length: 6,
        animationCurve: Curves.bounceInOut,
        keyboardType: TextInputType.number,
        keyboardAppearance: Brightness.dark,
        boxShadows: [BoxShadow(color: Colors.white)],
        autoDismissKeyboard: true,
        enableActiveFill: true,
        cursorColor: Colors.black,
        pinTheme: PinTheme(
          fieldHeight: 53,
          fieldWidth: 34,
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          inactiveColor: const Color.fromARGB(
            1,
            0,
            0,
            0,
          ), //Override default red to fully transparent
          activeColor: const Color.fromARGB(
            1,
            0,
            0,
            0,
          ), //Override default green to fully transparent
          selectedColor: Colors.white,
          selectedFillColor: Colors.white,
          inactiveFillColor: Colors.white,
          activeFillColor: Colors.white,
        ),
      ),
    );
  }
}
