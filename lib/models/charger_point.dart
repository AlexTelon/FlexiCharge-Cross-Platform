import 'package:flexicharge/models/charger.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ChargerPoint {
  int chargerPointId = -1;
  LatLng coordinates = LatLng(0.0, 0.0) ;
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
    coordinates = LatLng(json['location'][0], json['location'][1]);
  }
}
