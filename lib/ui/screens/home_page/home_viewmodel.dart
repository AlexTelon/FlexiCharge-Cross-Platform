import 'dart:async';
import 'package:flexicharge/app/app.locator.dart';
import 'package:flexicharge/enums/bottom_sheet_type.dart';
import 'package:flexicharge/models/charger.dart';
import 'package:flexicharge/services/chargers.dart';
import 'package:flexicharge/services/local_data.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final chagerAPI = locator<ChargerService>();
  final localData = locator<LocalData>();
  final bottomSheetService = locator<BottomSheetService>();

  init() {
    getUserLocation();
  }

  Completer<GoogleMapController> controller = Completer();

  CameraPosition cameraPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  List<Charger> get chargers => localData.chargers;

  void getUserLocation() =>
      Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
          .then(
        (value) {
          cameraPosition = CameraPosition(
            target: LatLng(value.latitude, value.longitude),
            zoom: 14.4746,
          );
          notifyListeners();
          print(value.latitude);
        },
      );

  Future<void> openFindCharger() async {
    bottomSheetService.showCustomSheet(variant: BottomSheetType.mapBottomSheet);
  }
}
