import 'package:flexicharge/models/charger.dart';
import 'package:flutter/material.dart';

class Plug extends StatelessWidget {
  const Plug({required this.charger, Key? key}) : super(key: key);
  final Charger charger;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 130,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          border: Border.all(color: const Color(0xff78bd76), width: 3),
          color: const Color(0xffffffff),
        ),
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
                Text(charger.type),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  charger.id.toString(),
                  style: const TextStyle(
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w400,
                      fontFamily: "Lato",
                      fontStyle: FontStyle.normal,
                      fontSize: 11.0),
                ), // AC 7kW
                Text(
                  charger.capacity,
                  style: const TextStyle(
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w400,
                      fontFamily: "Lato",
                      fontStyle: FontStyle.normal,
                      fontSize: 11.0),
                ), // 3.00 kr/kWh
                Text(
                  charger.cost,
                  style: const TextStyle(
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w400,
                      fontFamily: "Lato",
                      fontStyle: FontStyle.normal,
                      fontSize: 11.0),
                ), // Available
                Text(
                  charger.status == 0
                      ? 'avaible'
                      : charger.status == 1
                          ? 'occupid'
                          : 'booked',
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
      ),
    );
  }
}
