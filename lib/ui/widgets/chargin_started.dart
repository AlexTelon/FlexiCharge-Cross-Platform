import 'package:flexicharge/ui/widgets/map_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ChargingStarted extends StatelessWidget {
  const ChargingStarted(
      {Key? key, required this.imageOne, required this.imageTwo})
      : super(key: key);

  final SvgPicture imageOne;
  final SvgPicture imageTwo;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.2,
            height: MediaQuery.of(context).size.height * 0.2,
            color: Color.fromARGB(220, 21, 21, 21),
            child: imageOne,
          ),
          // Rectangle Copy 20
          // Fill 1
          Container(
              width: MediaQuery.of(context).size.width * 0.1,
              height: MediaQuery.of(context).size.height * 0.05,
              decoration: BoxDecoration(color: const Color(0xffffffff))),
          Container(
            width: MediaQuery.of(context).size.width * 0.2,
            height: MediaQuery.of(context).size.height * 0.2,
            color: Color.fromARGB(220, 21, 21, 21),
            child: imageTwo,
          ),
        ],
      ),
    );
  }
}
