import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MapIcon extends StatelessWidget {
  
  const MapIcon({ Key? key, required this.onTap,  this.isLarge = false,  required this.icon}) : super(key: key);
  final Function()? onTap;
  final bool isLarge;
  final IconData icon; 

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child:ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(isLarge ? 70:50)),
        child: Container(
          width: isLarge ? 70:50,
          height: isLarge ? 70:50,
          color: Colors.grey,
          child: Icon(icon),
        ),
      ),
    );
  }
}