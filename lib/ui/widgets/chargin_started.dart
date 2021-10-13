import 'package:flutter/material.dart';

class ChargingStarted extends StatelessWidget {
  final Function chargingPercentage;

  const ChargingStarted({
    Key? key,
    required this.chargingPercentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    chargingPercentage();
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Image(
                width: MediaQuery.of(context).size.width * 0.25,
                height: MediaQuery.of(context).size.height * 0.30,
                image: AssetImage('assets/images/smallFlexiChargeLogo.png')),
          ),
          // Rectangle Copy 20
          // Fill 1
          Container(
              child: Image(
            width: MediaQuery.of(context).size.height * 0.1,
            height: MediaQuery.of(context).size.height * 0.1,
            image: AssetImage('assets/images/white_arrow.png'),
          )),
          Container(
            child: Image(
                width: MediaQuery.of(context).size.width * 0.25,
                height: MediaQuery.of(context).size.height * 0.30,
                image: AssetImage('assets/images/whiteCheck.png')),
          ),
        ],
      ),
    );
  }
}
