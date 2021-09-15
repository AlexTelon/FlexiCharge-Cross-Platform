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
    return Center(
      child: Container(
        child: PinCodeTextField(
          appContext: context,
          length: 6,
          onChanged: onChanged,
          animationCurve: Curves.bounceInOut,
          keyboardType: TextInputType.number,
          keyboardAppearance: Brightness.dark,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(5),
            fieldHeight: 50,
            fieldWidth: 40,
          ),
          boxShadows: [BoxShadow(color: Colors.white)],
        ),
      ),
    );
  }
}
