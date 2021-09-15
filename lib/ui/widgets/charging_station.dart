import 'package:flutter/material.dart';

class ChargingStation extends StatelessWidget {
  const ChargingStation(
      {required this.adress, required this.currentLocation, Key? key})
      : super(key: key);
  final String adress;
  final String currentLocation;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(children: [
          Text(
            adress,
            style: TextStyle(color: Colors.white),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.fmd_good_sharp, color: Colors.green[500]),
              Text(
                currentLocation,
                style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Lato",
                    fontStyle: FontStyle.normal,
                    fontSize: 15.0),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
