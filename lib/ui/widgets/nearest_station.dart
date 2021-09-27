import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NearestStation extends StatelessWidget {
  const NearestStation({
    required this.location,
    required this.chargers,
    required this.onTap,
    required this.distance,
    Key? key,
  }) : super(key: key);

  final String location;
  final int chargers;
  final Function()? onTap;
  final String distance;

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
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              chargers == 0
                  ? Text(
                      'Sorry This Charging Station Contains No Available Chargers',
                      style: TextStyle(
                        fontFamily: 'Lato',
                        color: Colors.red,
                        fontSize: 10,
                      ),
                    )
                  : Row(
                      children: List<Widget>.generate(
                        chargers,
                        (index) => Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Image.asset(
                            "assets/images/charger_icon.png",
                            width: 20,
                            height: 20,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
            ],
          ),
          Column(
            children: [
              Text(
                distance,
                style: TextStyle(
                  fontFamily: 'Lato',
                  color: Color(0xffffffff),
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  letterSpacing: -0.408,
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
