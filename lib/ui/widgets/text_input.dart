import 'package:flexicharge/theme.dart';
import 'package:flutter/material.dart';

/// A widget that displays a text input field with a label and a hint
/// This class is a stateless widget that takes in a text editing controller,
/// a label text, a hint, a boolean for whether or not the text is a password,
/// a boolean for whether or not the text is a
/// number, a default input, and a function that
/// takes in a string and returns nothing
class TextInputWidget extends StatelessWidget {
  const TextInputWidget({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.hint,
    required this.onChanged,
    this.isPassword = false,
    this.isNumber = false,
    this.defaultInput,
  }) : super(key: key);

  final TextEditingController controller;
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
        controller: controller,
        obscureText: isPassword,
        onChanged: onChanged,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hint,
          border: UnderlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: FlexiChargeTheme.darkGrey),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: FlexiChargeTheme.darkGrey),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
    );
  }
}
