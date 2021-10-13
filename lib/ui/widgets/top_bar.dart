import 'package:flutter/material.dart';

class Topbar extends StatelessWidget {
  const Topbar({Key? key, required this.text, this.onTap}) : super(key: key);
  final String text;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            width: double.infinity,
            height: 228,
            decoration: BoxDecoration(color: Color(0xff292b2b)),
            padding: EdgeInsets.all(10),
            transform: Matrix4.skewY(-0.2)),
        Column(children: [
          SizedBox(height: 80),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7.0),
            child: Row(
              children: [
                if (onTap != null)
                  InkWell(
                    onTap: onTap,
                    child: Icon(
                      Icons.arrow_back_ios_sharp,
                      size: 30,
                      color: Color(0xffffffff),
                    ),
                  ),
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(
                      fontFamily: 'ITCAvantGardeStd-Bold',
                      color: Color(0xffffffff),
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ]),
      ],
    );
  }
}
