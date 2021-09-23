import 'package:flexicharge/models/charger.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocalData {
  List<Charger> chargers = [
    Charger.fromCharger(
      id: 201820,
      chargerPointId: 1,
      status: 1,
      type: 'threePin',
      capacity: 'threeKW',
      cost: 'threeKrKWh',
    ),
    Charger.fromCharger(
      id: 201820,
      chargerPointId: 1,
      status: 0,
      type: 'fourPin',
      capacity: 'fourKW',
      cost: 'fourKrKWh',
    ),
    Charger.fromCharger(
      id: 201820,
      chargerPointId: 1,
      status: 2,
      type: 'fivePin',
      capacity: 'fiveKW',
      cost: 'fiveKrKWh',
    ),
    Charger.fromCharger(
      id: 201820,
      chargerPointId: 1,
      status: 3,
      type: 'sixPin',
      capacity: 'sixKW',
      cost: 'sixKrKWh',
    ),
    Charger.fromCharger(
      id: 201820,
      chargerPointId: 1,
      status: 3,
      type: 'sixPin',
      capacity: 'sixKW',
      cost: 'sixKrKWh',
    ),
  ];
}
