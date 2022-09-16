import 'package:flutter/material.dart';

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
          height: MediaQuery.of(context).size.height * 0.10,
          width: MediaQuery.of(context).size.width * 0.90,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: const Color(0xff333333)),
          child: TextButton(
            onPressed: onPressed,
            child: Text(
              buttonText,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ));
  }
}
