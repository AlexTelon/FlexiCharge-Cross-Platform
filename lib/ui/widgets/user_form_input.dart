import 'package:flexicharge/theme.dart';
import 'package:flutter/material.dart';

/// A class that is used to create a text field for user input.
/// This class is a stateless widget that takes in a text editing controller,
/// a label text, a hint, a validator, a suffix icon, a boolean value for
/// whether or not the input is a password, and a default input.
/// It then returns a fractionally sized box that contains a text form field
/// with the given parameters
class UserFormInput extends StatelessWidget {
  const UserFormInput({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.hint,
    required this.validator,
    required this.suffixIcon,
    this.isPassword = false,
    this.defaultInput,
  }) : super(key: key);

  final TextEditingController controller;
  final String hint;
  final String labelText;
  final bool isPassword;
  final String? defaultInput;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    if (defaultInput != null) {
      controller.text = defaultInput!;
    }
    return FractionallySizedBox(
      widthFactor: 0.8,
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        validator: validator,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hint,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: FlexiChargeTheme.midGrey),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: FlexiChargeTheme.midGrey),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: FlexiChargeTheme.midGrey),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: FlexiChargeTheme.midGrey),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
    );
  }
}
