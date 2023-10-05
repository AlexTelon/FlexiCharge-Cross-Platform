import 'package:flexicharge/models/charger.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// The class has a constructor that takes a Map<String, dynamic> as a parameter
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

  /// The `ChargerPoint.fromJson` method is a factory constructor that takes a `Map<String, dynamic>` as a
  /// parameter. It is used to create a `ChargerPoint` object from a JSON representation.
  ChargerPoint.fromJson(Map<String, dynamic> json) {
    chargerPointId = json['chargePointID'];
    coordinates =
        LatLng(json['location'][0].toDouble(), json['location'][1].toDouble());
    name = json['name'] ?? '';
    price = json['price'] ?? '';
  }
}
