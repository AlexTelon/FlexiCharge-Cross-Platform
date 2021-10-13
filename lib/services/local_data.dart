import 'dart:async';

import 'package:flexicharge/enums/event_type.dart';
import 'package:flexicharge/models/charger.dart';
import 'package:flexicharge/models/charger_point.dart';
import 'package:flexicharge/models/transaction.dart';
import 'package:flexicharge/models/user.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocalData {
  List<Charger> chargers = [];
  String qrCode = '';
  List<ChargerPoint> chargerPoints = [];
  LatLng userLocation = LatLng(0, 0);
  int chargingCharger = -1;
  Transaction transactionSession = Transaction();
  bool isButtonActive = true;
  User user = User();
  int chargingPercentage = 0;
  late Timer timer;
  late StreamController<EventType> controller;
  late Stream stream;

  LocalData() {
    controller = StreamController.broadcast();
    stream = controller.stream;
  }

  BitmapDescriptor greenMarkerIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor redMarkerIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor blackMarkerIcon = BitmapDescriptor.defaultMarker;
}
