import 'package:flutter/material.dart';

/// This class is a stateless widget that takes in an error message
/// and a default input. It then returns a fractionally sized box that
/// contains a text widget with the error message
class ErrorText extends StatelessWidget {
  const ErrorText({
    Key? key,
    required this.errorMessage,
    this.defaultInput,
  }) : super(key: key);

  final String errorMessage;
  final String? defaultInput;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.8,
      child: Text(
        errorMessage,
        style: TextStyle(
          color: Colors.red,
          fontSize: 15,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
