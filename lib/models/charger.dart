import 'package:google_maps_flutter/google_maps_flutter.dart';

class Charger {
  int id = -1;
  int chargerPointId = 0;
  String status = '';
  LatLng coordinates = LatLng(0, 0);
  String capacity = '';
  String cost = '';
  String type = '';

  Charger();
  Charger.fromCharger({
    required this.id,
    required this.chargerPointId,
    required this.status,
    // required this.coordinates,
    required this.capacity,
    required this.cost,
    required this.type,
  });

  Charger.fromJson(Map<String, dynamic> json) {
    id = json['chargerID'];
    chargerPointId = json['chargePointID'];
    status = json['status'] ?? '';
    // coordinates = json['location'];
    capacity = json['capacity'] ?? '';
    cost = json['price'] ?? '';
    type = json['type'] ?? '';
  }
}

/*
  "chargerID": 1,
  "location": "string",
  "cooidinates": "57.999, 50.67",
  "chargePointID": 3,
  "status": 1  
 */