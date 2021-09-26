import 'package:flutter/material.dart';

class TextInputWidget extends StatelessWidget {
  const TextInputWidget({
    Key? key,
    required this.labelText,
    required this.hint,
    required this.onChanged,
    this.isPassword = false,
    this.isNumber = false,
    this.defaultInput,
  }) : super(key: key);

  final String hint;
  final String labelText;
  final bool isPassword;
  final bool isNumber;
  final String? defaultInput;
  final Function(String) onChanged;
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.8,
      child: TextField(
        obscureText: isPassword,
        onChanged: onChanged,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hint,
          border: UnderlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff292b2b)),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff292b2b)),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
    );
  }
}
