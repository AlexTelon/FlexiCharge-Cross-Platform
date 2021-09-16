import 'package:flutter/material.dart';

class ChargingInProgress extends StatelessWidget {
  const ChargingInProgress(
      {Key? key,
      required this.batteryProcent,
      required this.chargingAdress,
      required this.timeUntilFullyCharged,
      required this.kilowattHours})
      : super(key: key);

  final int batteryProcent;
  final String chargingAdress;
  final String timeUntilFullyCharged;
  final String kilowattHours;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                width: 25,
                height: 25,
                image: AssetImage('assets/images/lightningIcon.png'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(batteryProcent.toString(),
                      style: const TextStyle(
                          color: const Color(0xffffffff),
                          fontWeight: FontWeight.w400,
                          fontFamily: "Lato",
                          fontStyle: FontStyle.normal,
                          fontSize: 30.0),
                      textAlign: TextAlign.right),
                  Text("%",
                      style: const TextStyle(
                          color: const Color(0xffffffff),
                          fontWeight: FontWeight.w400,
                          fontFamily: "Lato",
                          fontStyle: FontStyle.normal,
                          fontSize: 14.0),
                      textAlign: TextAlign.right)
                ],
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Image(
                      width: 20,
                      height: 20,
                      image: AssetImage('assets/images/white_marker.png')),
                  Text("Kungsgatan 1a, Jönköping",
                      style: const TextStyle(
                          color: const Color(0xffffffff),
                          fontWeight: FontWeight.w400,
                          fontFamily: "Lato",
                          fontStyle: FontStyle.normal,
                          fontSize: 17.0),
                      textAlign: TextAlign.right),
                ],
              ),
              Row(
                children: [
                  Image(
                      width: 20,
                      height: 20,
                      image: AssetImage('assets/images/white_alarm_clock.png')),
                  Text("1hr 21min until full",
                      style: const TextStyle(
                          color: const Color(0xffffffff),
                          fontWeight: FontWeight.w400,
                          fontFamily: "Lato",
                          fontStyle: FontStyle.normal,
                          fontSize: 17.0),
                      textAlign: TextAlign.right),
                ],
              ),
              Row(
                children: [
                  Image(
                      width: 20,
                      height: 20,
                      image: AssetImage('assets/images/lightningIcon.png')),
                  Text("5,72kwh at 3kwh",
                      style: const TextStyle(
                          color: const Color(0xffffffff),
                          fontWeight: FontWeight.w400,
                          fontFamily: "Lato",
                          fontStyle: FontStyle.normal,
                          fontSize: 17.0),
                      textAlign: TextAlign.right)
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
