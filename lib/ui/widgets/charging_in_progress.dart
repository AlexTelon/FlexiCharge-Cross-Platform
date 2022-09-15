import 'package:flexicharge/ui/widgets/circular_loading_bar.dart';
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
      height: 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.10,
            width: MediaQuery.of(context).size.height * 0.10,
            child: CircularLoadingBar(
              loadingPercentage: batteryProcent / 100,
            ),
          ),
          FittedBox(
            fit: BoxFit.fitHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
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
