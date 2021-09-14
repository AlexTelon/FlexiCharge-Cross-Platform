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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                Icons.ac_unit,
                color: Colors.pink,
                size: 24.0,
              ),
              Text('Type'),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "123456",
                style: const TextStyle(
                    color: const Color(0xff000000),
                    fontWeight: FontWeight.w400,
                    fontFamily: "Lato",
                    fontStyle: FontStyle.normal,
                    fontSize: 11.0),
              ), // AC 7kW
              Text(
                "AC  7kW",
                style: const TextStyle(
                    color: const Color(0xff000000),
                    fontWeight: FontWeight.w400,
                    fontFamily: "Lato",
                    fontStyle: FontStyle.normal,
                    fontSize: 11.0),
              ), // 3.00 kr/kWh
              Text(
                "3.00 kr/kWh",
                style: const TextStyle(
                    color: const Color(0xff000000),
                    fontWeight: FontWeight.w400,
                    fontFamily: "Lato",
                    fontStyle: FontStyle.normal,
                    fontSize: 11.0),
              ), // Available
              Text(
                "Available",
                style: const TextStyle(
                    color: const Color(0xff78bd76),
                    fontWeight: FontWeight.w400,
                    fontFamily: "Lato",
                    fontStyle: FontStyle.normal,
                    fontSize: 11.0),
              ),
            ],
          ),
        ],
      ),
      width: 130,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
        border: Border.all(color: const Color(0xff78bd76), width: 3),
        color: const Color(0xffffffff),
      ),
    );
  }
}
