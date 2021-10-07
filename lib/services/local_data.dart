import 'package:flexicharge/models/charger.dart';
import 'package:flexicharge/models/charger_point.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocalData {
  List<Charger> chargers = [];
  String qrCode = '';
  List<ChargerPoint> chargerPoints = [];
  LatLng userLocation = LatLng(0, 0);
  int _chargingCharger = -1;

  int get chargingCharger => _chargingCharger;
  set chargingCharger(int newId) {
    _chargingCharger = newId;
  }

  bool _isButtonActive = true;
  bool get isButtonActive => _isButtonActive;
  set isButtonActive(bool newState) {
    _isButtonActive = newState;
  }

  BitmapDescriptor greenMarkerIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor redMarkerIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor blackMarkerIcon = BitmapDescriptor.defaultMarker;
}
