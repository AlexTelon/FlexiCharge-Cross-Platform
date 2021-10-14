import 'package:flexicharge/models/charger.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ChargerPoint {
  int chargerPointId = -1;
  String name = '';
  LatLng coordinates = LatLng(0.0, 0.0);
  String price = '';
  List<Charger> chargers = [];
  ChargerPoint();
  ChargerPoint.fromCharger({
    required this.chargerPointId,
    required this.coordinates,
    required this.chargers,
    required this.name,
    required this.price,
  });

  ChargerPoint.fromJson(Map<String, dynamic> json) {
    chargerPointId = json['chargePointID'];
    coordinates = LatLng(json['location'][0], json['location'][1]);
    name = json['name'] ?? '';
    price = json['price'] ?? '';
  }
}
