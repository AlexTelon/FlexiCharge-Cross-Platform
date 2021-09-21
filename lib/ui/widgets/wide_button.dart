import 'package:flutter/material.dart';

class WideButton extends StatelessWidget {
  const WideButton(
      {Key? key, required this.color, required this.text, required this.onTap})
      : super(key: key);
  final Color color;
  final String text;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 300,
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: color,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'ITCAvantGardePro',
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal,
            letterSpacing: -0.3839999999999999,
          ),
        ),
      ),
    );
  }
}
