import 'package:flexicharge/theme.dart';
import 'package:flutter/material.dart';

/// This class is a button that is used in the app
/// for stopping a charging session
class StopChargingButton extends StatelessWidget {
  const StopChargingButton(
      {Key? key, required this.onPressed, required this.buttonText})
      : super(key: key);

  final String buttonText;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fitWidth,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.07,
        width: MediaQuery.of(context).size.width * 0.90,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(30)),
            color: FlexiChargeTheme.midGrey),
        child: TextButton(
          onPressed: onPressed,
          child: Text(
            buttonText,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ),
    );
  }
}
