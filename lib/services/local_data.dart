import 'package:flexicharge/models/charger.dart';
import 'package:flexicharge/models/charger_point.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocalData {
  List<ChargerPoint> chargerPoints = List<ChargerPoint>.generate(10, (index) {
    return ChargerPoint.fromCharger(
        chargerPointId: index,
        coordinates: LatLng(index.toDouble(), index.toDouble()),
        chargers: List<Charger>.generate(
            6,
            (indexx) => Charger.fromCharger(
                id: indexx,
                chargerPointId: index,
                status: 1,
                capacity: '',
                cost: '',
                type: '')));
  });
}
