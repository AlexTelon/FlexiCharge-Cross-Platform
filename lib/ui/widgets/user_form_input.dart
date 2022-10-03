import 'package:flutter/material.dart';

/// A class that is used to create a text field for user input.
class UserFormInput extends StatelessWidget {
  const UserFormInput({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.hint,
    required this.validator,
    this.isPassword = false,
    this.defaultInput,
  }) : super(key: key);

  final TextEditingController controller;
  final String hint;
  final String labelText;
  final bool isPassword;
  final String? defaultInput;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.8,
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        validator: validator,
        decoration: InputDecoration(
            labelText: labelText,
            hintText: hint,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff292b2b)),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff292b2b)),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff292b2b)),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff292b2b)),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            )),
      ),
    );
  }
}
