import 'package:flutter/material.dart';

import 'package:flexicharge/services/local_data.dart';

class ChargerLocations extends StatelessWidget {
  const ChargerLocations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, 
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Kungsgatan 1a, Jönköping',
                    style: TextStyle(
                      fontFamily: 'Lato',
                      color: Color(0xffffffff),
                      fontSize: 17,
                    ),
                  ),
                  Icon(Icons.track_changes_sharp),
                ],
              ),
              Text(
                '565m',
                style: TextStyle(
                  fontFamily: 'Lato',
                  color: Color(0xffffffff),
                  fontSize: 17,
                ),
                textAlign: TextAlign.end
              ),
            ],
          );
        },
      ),
    );
  }
}
