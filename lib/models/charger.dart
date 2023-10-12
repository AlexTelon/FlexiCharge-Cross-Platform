import 'package:google_maps_flutter/google_maps_flutter.dart';

/// The class has a constructor that takes a map of strings to dynamic objects.
/// The constructor then assigns the values of the map to the class properties
class Charger {
  int id = -1;
  int chargerPointId = 0;
  String status = '';
  String serialNumber = "";
  LatLng location = LatLng(0, 0);
  String capacity = '';
  int cost = 0;
  String type = '';

  Charger();
  Charger.fromCharger({
    required this.id,
    required this.chargerPointId,
    required this.status,
    required this.location,
    required serialNumber,
    this.capacity = '',
    required this.cost,
    this.type = '',
  });

  Charger.fromJson(Map<String, dynamic> json) {
    id = json['connectorID'];
    location =
        LatLng(json['location'][0].toDouble(), json['location'][1].toDouble());
    serialNumber = json["serialNumber"] ?? "";
    status = json['status'] ?? '';
    chargerPointId = json['chargePointID'];
  }
}
