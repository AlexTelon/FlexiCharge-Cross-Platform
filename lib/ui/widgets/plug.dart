import 'package:flexicharge/models/charger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Plug extends StatelessWidget {
  const Plug(
      {required this.onTap,
      required this.isSelected,
      required this.charger,
      Key? key})
      : super(key: key);
  final Charger charger;
  final bool isSelected;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            width: 130,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
              border: isSelected
                  ? Border.all(color: const Color(0xff78bd76), width: 3)
                  : null,
              color: const Color(0xffffffff),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SvgPicture.asset(
                      'assets/svg_images/charger_type.svg',
                      fit: BoxFit.scaleDown,
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
                    ), // capacity
                    Text(
                      charger.capacity,
                      style: const TextStyle(
                          color: const Color(0xff000000),
                          fontWeight: FontWeight.w400,
                          fontFamily: "Lato",
                          fontStyle: FontStyle.normal,
                          fontSize: 11.0),
                    ), // cost kr/kWh
                    Text(
                      charger.cost,
                      style: const TextStyle(
                          color: const Color(0xff000000),
                          fontWeight: FontWeight.w400,
                          fontFamily: "Lato",
                          fontStyle: FontStyle.normal,
                          fontSize: 11.0),
                    ), // status
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
        ),
      ),
    );
  }
}