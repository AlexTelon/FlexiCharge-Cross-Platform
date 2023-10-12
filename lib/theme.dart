import 'package:flutter/material.dart';

//This class contains the official FlexiCharge theme colors
class FlexiChargeTheme {
  static const black = Color(0xff0000000);
  static const darkGrey = Color(0xff212121);
  static const midGrey = Color(0xff333333);
  static const lightMidGrey = Color(0xff868686);
  static const lightGrey = Color(0xffe5e5e5);
  static const white = Color(0xffffffff);
  static const green = Color(0xff78bd76);
  static const yellow = Color(0xfff0c200);
  static const blue = Color(0xff5e5eb7);
  static const red = Color(0xffef6048);
}

class Style {
  static TextStyle regularText = TextStyle(
    fontFamily: 'Lato',
    color: FlexiChargeTheme.darkGrey,
    fontSize: 13,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
  );

  static TextStyle linkText = TextStyle(
    fontFamily: 'Lato',
    color: FlexiChargeTheme.green,
    fontSize: 13,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
  );

  static TextStyle higlightedText = TextStyle(
    fontFamily: 'Lato',
    color: FlexiChargeTheme.darkGrey,
    fontSize: 19,
    fontWeight: FontWeight.w800,
    fontStyle: FontStyle.normal,
  );
}
