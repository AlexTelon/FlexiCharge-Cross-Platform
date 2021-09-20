import 'package:flutter/material.dart';

class NearestStation extends StatelessWidget {
  const NearestStation({
    required this.location,
    required this.distance,
    required this.chargers,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final String location, distance;
  final int chargers;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                location,
                style: TextStyle(
                  fontFamily: 'Lato',
                  color: Color(0xffffffff),
                  fontSize: 17,
                ),
              ),
              Image.asset("assets/images/charger_icon.png",
                  width: 18, height: 16, fit: BoxFit.fill),
            ],
          ),
          Column(
            children: [
              Text(
                distance,
                style: TextStyle(
                  fontFamily: 'Lato',
                  color: Color(0xffffffff),
                  fontSize: 17,
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
