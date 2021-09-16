import 'package:flutter/material.dart';

class NearestStation extends StatelessWidget {
  const NearestStation({
    required this.location,
    required this.distance,
    required this.chargers,
    Key? key,
  }) : super(key: key);

  final String location, distance;
  final int chargers;

  @override
  Widget build(BuildContext context) {
    return Row(
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
            Icon(
              Icons.track_changes_sharp,
              color: Colors.white,
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
                fontSize: 17,
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ],
    );
  }
}