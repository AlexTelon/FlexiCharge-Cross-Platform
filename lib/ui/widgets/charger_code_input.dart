import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ChargerCodeInput extends StatelessWidget {
  const ChargerCodeInput({
    required this.onChanged,
    required this.validator,
    Key? key,
  }) : super(key: key);
  final Function(String) onChanged;
  final String Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PinCodeTextField(
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
        pinTheme: PinTheme(
          fieldHeight: 53,
          fieldWidth: 34,
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          inactiveColor: const Color.fromARGB(
              1, 0, 0, 0), //Override default red to fully transparent
          activeColor: const Color.fromARGB(
              1, 0, 0, 0), //Override default green to fully transparent
        ),
      ),
    );
  }
}
