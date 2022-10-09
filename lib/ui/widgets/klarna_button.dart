import 'package:flexicharge/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class KlarnaButton extends StatelessWidget {
  const KlarnaButton({Key? key, required this.onTap, this.isSelected = false})
      : super(key: key);
  final Function()? onTap;
  final bool? isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 150,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: isSelected == true
              ? Border.all(color: FlexiChargeTheme.green, width: 3)
              : null,
          color: FlexiChargeTheme.white,
        ),
        // child: image,
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: SvgPicture.asset(
            "assets/svg_images/klarna_logo.svg",
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
    );
  }
}
