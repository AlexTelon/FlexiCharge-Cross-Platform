import 'package:flexicharge/models/charger.dart';
import 'package:flutter/material.dart';

import 'package:flexicharge/ui/widgets/nearest_station.dart';

class ChargerLocations extends StatelessWidget {
  const ChargerLocations(
      {required this.chargers, required this.onTap, Key? key})
      : super(key: key);
  final Function(int)? onTap;
  final List<Charger> chargers;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: chargers.map((charger) {
        return NearestStation(
            onTap: () => onTap != null ? onTap!(charger.id) : null,
            location: 'Kungsgatan 1a, Jönköping',
            distance: '544m',
            chargers: 2);
      }).toList(),
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