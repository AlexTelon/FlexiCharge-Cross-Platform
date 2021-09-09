import 'package:flexicharge/enums/charger_status.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Charger {
  String id = '';
  ChargerStatus status = ChargerStatus.available;
  LatLng location = LatLng(0, 0);
  String data = '';
  Charger();
  Charger.fromCharger(this.id, this.status, this.location, this.data);

  Charger.fromJson(Map<String, dynamic> json) {
    id = json['userId'];
    location = LatLng(json['latitude'], json['longitude']);
    switch (json['status']) {
      case 'booked':
        status = ChargerStatus.booked;
        break;
      case 'occupied':
        status = ChargerStatus.occupied;
        break;
      case 'available':
        status = ChargerStatus.available;
        break;
      default:
    }
  }
}

