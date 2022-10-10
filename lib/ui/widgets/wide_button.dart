import 'package:flutter/material.dart';

/// A button that is 300px wide and 48px tall, with a border radius of 8px,
/// and a background color of the color passed in, and a text color of white,
/// and a font size of 16px, and a font weight of 700, and a font style of normal,
/// and a letter spacing of -0.3839999999999999, and a font family of ITCAvantGardePro,
/// and a text of the text passed in, and a onTap of the onTap passed in, and a
/// visibility of the showWideButton passed in
class WideButton extends StatelessWidget {
  const WideButton({
    Key? key,
    required this.color,
    required this.text,
    required this.onTap,
    this.showWideButton = false,
  }) : super(key: key);
  final Color color;
  final String text;
  final bool showWideButton;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      key: ValueKey<bool>(showWideButton),
      visible: showWideButton,
      child: InkWell(
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
      ),
    );
  }
}
