import 'package:flexicharge/models/charger.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ChargerPoint {
  int chargerPointId = -1;
  List coordinates = [0.0, 0.0];
  List<Charger> chargers = [];

  ChargerPoint();
  ChargerPoint.fromCharger({
    required this.chargerPointId,
    required this.coordinates,
    required this.chargers,
  });

  ChargerPoint.fromJson(Map<String, dynamic> json) {
    var coordinatesList = (json['location'] as String).split(',');
    chargerPointId = json['chargePointID'];
    coordinates = [
      coordinatesList[0],
      coordinatesList[1],
    ];
  }
}
