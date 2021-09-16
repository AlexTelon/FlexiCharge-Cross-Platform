import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChargingStation extends StatelessWidget {
  const ChargingStation(
      {required this.onTap,
      required this.adress,
      required this.currentLocation,
      Key? key})
      : super(key: key);
  final String adress;
  final Function()? onTap;
  final String currentLocation;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: onTap,
            child: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
              size: 35,
            ),
          ),
          Column(
            children: [
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
              ),
            ],
          ),
          Text(""),
        ],
      ),
    );
  }
}
