import 'package:flutter/material.dart';

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
