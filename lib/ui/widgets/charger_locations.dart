import 'package:flutter/material.dart';

import 'package:flexicharge/enums/charger_status.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flexicharge/services/local_data.dart';

class ChargerLocations extends StatelessWidget {
  const ChargerLocations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Charger> chargers = [
      Charger('5412345', ChargerStatus.booked, LatLng(0023, 1230)),
      Charger('1234543', ChargerStatus.occupied, LatLng(123, 1230)),
      Charger('1225453', ChargerStatus.available, LatLng(5463, 1230)),
      Charger('1234543', ChargerStatus.available, LatLng(2433, 1230)),
      Charger('1654654', ChargerStatus.available, LatLng(2343, 1230)),
    ];

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
                  Icon(
                    Icons.track_changes_sharp,
                    color: Colors.white,
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    '565m',
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
        },
      ),
    );
  }
}

class Charger {
  String id = '';
  ChargerStatus status = ChargerStatus.available;
  LatLng location = LatLng(0, 0);

  Charger(this.id, this.status, this.location);
}
