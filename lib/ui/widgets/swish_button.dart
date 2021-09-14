import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SwichButton extends StatelessWidget {
  const SwichButton({Key? key, required this.onTap, this.isActive, this.isSelected}) : super(key: key);
  final Function()? onTap;
  final bool? isActive;
  final bool? isSelected;
  

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 150,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(5) 
          ),
          border: Border.all(
            color: const Color(0xff78bd76),
            width: 3
          ),
          color: const Color(0xffffffff),
        ),
        // child: image,
        child:Image.asset("assets/images/Swish-Logo.png")
      )
    );
  } 


}