import 'package:flutter/material.dart';

class Plug extends StatefulWidget {
  const Plug({Key? key}) : super(key: key);

  @override
  _PlugState createState() => _PlugState();
}

class _PlugState extends State<Plug> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
        border: Border.all(color: const Color(0xff78bd76), width: 3),
        color: const Color(0xffffffff),
      ),
      child: Column(
        children: [
          Stack(children: [
            // ellipse4206
            PositionedDirectional(
              top: 14,
              start: 14,
              child: Container(
                width: 5,
                height: 4,
                decoration: BoxDecoration(
                  border:
                      Border.all(color: const Color(0xff000000), width: 1.5525),
                ),
              ),
            ),
            // ellipse4208
            PositionedDirectional(
              top: 14,
              start: 7,
              child: Container(
                width: 5,
                height: 4,
                decoration: BoxDecoration(
                  border:
                      Border.all(color: const Color(0xff000000), width: 1.5525),
                ),
              ),
            ),
            // ellipse4210
            PositionedDirectional(
              top: 8,
              start: 4,
              child: Container(
                width: 5,
                height: 4,
                decoration: BoxDecoration(
                  border:
                      Border.all(color: const Color(0xff000000), width: 1.5525),
                ),
              ),
            ),
            // ellipse4212
            PositionedDirectional(
              top: 8,
              start: 11,
              child: Container(
                width: 5,
                height: 4,
                decoration: BoxDecoration(
                  border:
                      Border.all(color: const Color(0xff000000), width: 1.5525),
                ),
              ),
            ),
            // ellipse4214
            PositionedDirectional(
              top: 8,
              start: 18,
              child: Container(
                width: 5,
                height: 4,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xff000000),
                    width: 1.5525,
                  ),
                ),
              ),
            ),
            // ellipse4216
            PositionedDirectional(
              top: 3,
              start: 15,
              child: Container(
                width: 3,
                height: 3,
                decoration: BoxDecoration(
                  border:
                      Border.all(color: const Color(0xff000000), width: 1.5525),
                ),
              ),
            ),
            // ellipse4218
            PositionedDirectional(
              top: 3,
              start: 8,
              child: Container(
                width: 3,
                height: 3,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xff000000),
                    width: 1.5525,
                  ),
                ),
              ),
            ),
            // path4231
            PositionedDirectional(
              top: 0,
              start: 0,
              child: Container(
                width: 26,
                height: 23,
                decoration: BoxDecoration(
                  border:
                      Border.all(color: const Color(0xff000000), width: 2.7),
                ),
              ),
            )
          ]),
          // Type 2
          Text(
            "Type 2",
            style: const TextStyle(
                color: const Color(0xff000000),
                fontWeight: FontWeight.w400,
                fontFamily: "Lato",
                fontStyle: FontStyle.normal,
                fontSize: 11.0),
          ),
        ],
      ),
      // Type_2_mennekes
    );
  }
}
