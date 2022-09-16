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
              ? Border.all(color: const Color(0xff78bd76), width: 3)
              : null,
          color: const Color(0xffffffff),
        ),
        // child: image,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Invoice",
                style: TextStyle(
                  fontFamily: 'Lato',
                  color: Color(0xff212121),
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
                  color: Color(0xff212121),
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
