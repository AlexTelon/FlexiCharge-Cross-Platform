import 'package:flexicharge/ui/widgets/map_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ChargingStarted extends StatelessWidget {
  const ChargingStarted({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            child: Image(
                image: AssetImage('assets/images/smallFlexiChargeLogo.png')),
          ),
          // Rectangle Copy 20
          // Fill 1
          Container(
              child: Image(
            width: 50,
            height: 50,
            image: AssetImage('assets/images/white_arrow_right.png'),
          )),
          Container(
            child: Image(image: AssetImage('assets/images/whiteCheck.png')),
          ),
        ],
      ),
    );
  }
}
