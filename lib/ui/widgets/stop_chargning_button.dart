import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StopChargingButton extends StatelessWidget {
  const StopChargingButton({Key? key, required this.buttonText})
      : super(key: key);

  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: const Color(0xff333333)),
      child: TextButton(
        onPressed: () {},
        child: Text(
          buttonText,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
