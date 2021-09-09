import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MapIcon extends StatelessWidget {
  
  const MapIcon({ Key? key, required this.onTap, required this.isLarge,  required this.icon}) : super(key: key);
  final Function()? onTap;
  final bool isLarge;
  final Icon icon; 
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child:ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: Container(
          width: isLarge ? 10:20,
          height: isLarge ? 10:20,
          color: Colors.grey,
          child: icon,
        ),
      ),
    );
  }
}