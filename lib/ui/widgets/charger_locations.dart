import 'package:flutter/material.dart';

import 'package:flexicharge/enums/charger_status.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flexicharge/services/local_data.dart';
import 'package:flexicharge/ui/widgets/nearest_station.dart';

class ChargerLocations extends StatelessWidget {
  const ChargerLocations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   

    return Column(
      children: [
        NearestStation(location: 'Kungsgatan 1a, Jönköping', distance: '544m', chargers: 2),
        NearestStation(location: 'Asecs Röd Entre, Jönköping', distance: '1,2km', chargers: 2),
        NearestStation(location: 'Sjukhusgatan, Jönköping', distance: '1,5km', chargers: 2),
        NearestStation(location: 'Asecs Entry Am, Jönköping', distance: '2,3km', chargers: 2),
      ],
    );
  }
}


/*
class Charger {
  String id = '';
  ChargerStatus status = ChargerStatus.available;
  LatLng location = LatLng(0, 0);

  Charger(this.id, this.status, this.location);
}

 List<Charger> chargers = [
      Charger('5412345', ChargerStatus.booked, LatLng(0023, 1230)),
      Charger('1234543', ChargerStatus.occupied, LatLng(123, 1230)),
      Charger('1225453', ChargerStatus.available, LatLng(5463, 1230)),
      Charger('1234543', ChargerStatus.available, LatLng(2433, 1230)),
      Charger('1654654', ChargerStatus.available, LatLng(2343, 1230)),
    ];
    */