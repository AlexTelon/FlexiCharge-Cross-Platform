import 'package:flexicharge/theme.dart';
import 'package:flutter/material.dart';

class InvoiceButton extends StatelessWidget {
  const InvoiceButton(
      {Key? key, required this.onTap, this.underText, this.isSelected = false})
      : super(key: key);
  final Function()? onTap;
  final bool? isSelected;
  final String? underText;

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Invoice",
                style: TextStyle(
                  fontFamily: 'Lato',
                  color: FlexiChargeTheme.darkGrey,
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  letterSpacing: -0.408,
                )),
            if (underText != null)
              Text(
                underText!,
                style: TextStyle(
                  fontFamily: 'Lato',
                  color: FlexiChargeTheme.darkGrey,
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  letterSpacing: -0.264,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
