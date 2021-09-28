import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChargingStation extends StatelessWidget {
  const ChargingStation({
    required this.onTap,
    required this.address,
    required this.currentLocation,
    Key? key,
  }) : super(key: key);
  final String address;
  final Function()? onTap;
  final String currentLocation;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
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
                address,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Lato-Regular',
                ),
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
                      fontFamily: "Lato-Regular",
                      fontStyle: FontStyle.normal,
                      fontSize: 13.0,
                    ),
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
