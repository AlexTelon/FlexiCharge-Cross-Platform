import 'package:flexicharge/models/charger.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocalData {
  List<Charger> chargers = [
    Charger.fromCharger(
      id: 201820,
      status: 1,
      type: 'threePin',
      capacity: 'threeKW',
      cost: 'threeKrKWh',
      location: LatLng(123.5, 1321.5),
    ),
    Charger.fromCharger(
      id: 201920,
      status: 0,
      type: 'fourPin',
      capacity: 'fourKW',
      cost: 'fourKrKWh',
      location: LatLng(321.5, 248.5),
    ),
    Charger.fromCharger(
      id: 202020,
      status: 2,
      type: 'fivePin',
      capacity: 'fiveKW',
      cost: 'fiveKrKWh',
      location: LatLng(444.8, 3331.6),
    ),
    Charger.fromCharger(
      id: 202120,
      status: 3,
      type: 'sixPin',
      capacity: 'sixKW',
      cost: 'sixKrKWh',
      location: LatLng(666.8, 555.6),
    ),
  ];
}
