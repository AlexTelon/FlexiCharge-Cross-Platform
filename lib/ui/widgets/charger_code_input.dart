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
      width: 300,
      child: PinCodeTextField(
        onChanged: onChanged,
        onCompleted: validator,
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
          inactiveColor: const Color(0xff333333), //Override default red
          activeColor: const Color(0xff333333), //Override default green
        ),
      ),
    );
  }
}
