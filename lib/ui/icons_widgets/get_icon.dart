import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AssetsIcon extends StatelessWidget {
  const AssetsIcon({ Key? key, required this.assetName}) : super(key: key);
    final String assetName;


  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      semanticsLabel: 'Acme Logo',
      color: Colors.black,
    
    );
  }
}