import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MapIcon extends StatelessWidget {
  const MapIcon(
      {Key? key,
      required this.onTap,
      this.isActive = true,
      this.isLarge = false,
      required this.icon})
      : super(key: key);
  final Function()? onTap;
  final bool isActive;
  final bool isLarge;
  final SvgPicture icon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isActive ? onTap : null,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(isLarge ? 80 : 50)),
        child: Container(
          width: isLarge ? 70 : 50,
          height: isLarge ? 70 : 50,
          color: isActive
              ? Color.fromARGB(220, 21, 21, 21)
              : Color.fromARGB(110, 21, 21, 21),
          child: icon,
        ),
      ),
    );
  }
}
