import 'package:flexicharge/models/charger.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// The class has a constructor that takes a Map<String, dynamic> as a parameter
class ChargerPoint {
  int chargerPointId = -1;
  String name = '';
  String address = "";
  LatLng location = LatLng(0.0, 0.0);
  int price = 0;
  int klarnaReservationAmount = 0;
  List<Charger> chargers = [];

  ChargerPoint();
  ChargerPoint.fromCharger(
      {required this.chargerPointId,
      required this.location,
      required this.chargers,
      required this.address,
      required this.name,
      required this.price,
      required this.klarnaReservationAmount});

  /// The `ChargerPoint.fromJson` method is a factory constructor that takes a `Map<String, dynamic>` as a
  /// parameter. It is used to create a `ChargerPoint` object from a JSON representation.
  ChargerPoint.fromJson(Map<String, dynamic> json) {
    chargerPointId = json['chargePointID'];
    location =
        LatLng(json['location'][0].toDouble(), json['location'][1].toDouble());
    address = json["address"];
    name = json['name'] ?? '';
    price = json['price'] ?? null;
    klarnaReservationAmount = json["klarnaReservationAmount"];
  }
}
