import 'package:google_maps_flutter/google_maps_flutter.dart';

class Charger {
  int id = -1;
  LatLng location = LatLng(0, 0);
  int status = 0;
  String capacity = '';
  String cost = '';
  String type = '';

  Charger();
  Charger.fromCharger({
    required this.id,
    required this.location,
    required this.status,
    required this.capacity,
    required this.cost,
    required this.type,
  });
  Charger.fromJson(Map<String, dynamic> json) {
    id = json['chargerId'];
    location = LatLng(json['latitude'], json['longitude']);
    status = json['status'];
    capacity = json['capacity'];
    cost = json['cost'];
    type = json['type'];
  }
}
