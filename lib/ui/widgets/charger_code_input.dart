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
        appContext: context,
        length: 6,
        onChanged: onChanged,
        animationCurve: Curves.easeInOut,
        autoFocus: true,
        boxShadows: [BoxShadow()],
      ),
    );
  }
}
