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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FittedBox(
            fit: BoxFit.fitHeight,
            child: Column(
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
                            fontSize: 20.0),
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
          ),
          FittedBox(
            fit: BoxFit.fitHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(
                  // Adress
                  fit: BoxFit.fitWidth,
                  child: Row(
                    children: [
                      Image(
                          width: 20,
                          height: 20,
                          image: AssetImage('assets/images/white_marker.png')),
                      Text(
                        "Kungsgatan 1a, Jönköping",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                ),
                FittedBox(
                  // Time until full
                  fit: BoxFit.fitWidth,
                  child: Row(
                    children: [
                      Image(
                          width: 20,
                          height: 20,
                          image: AssetImage(
                              'assets/images/white_alarm_clock.png')),
                      Text("1hr 21min until full",
                          style: Theme.of(context).textTheme.bodyText1),
                    ],
                  ),
                ),
                FittedBox(
                  // Energy measurement
                  fit: BoxFit.fitWidth,
                  child: Row(
                    children: [
                      Image(
                          width: 20,
                          height: 20,
                          image: AssetImage('assets/images/lightningIcon.png')),
                      Text("5,72kwh at 3kwh",
                          style: Theme.of(context).textTheme.bodyText1)
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
