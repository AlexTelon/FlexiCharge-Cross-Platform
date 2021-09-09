import 'dart:async';
import 'package:flexicharge/app/app.locator.dart';
import 'package:flexicharge/services/chargers.dart';
import 'package:flexicharge/services/local_data.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  
  final chagerAPI = locator<ChargerService> ();
  final localData = locator<LocalData> ();

  init() {
    getUserLocation();
  }

  String _chargerCode = '';
  Completer<GoogleMapController> controller = Completer();
  final SnappingSheetController _snappingSheetController =
      SnappingSheetController();

  CameraPosition cameraPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  SnappingSheetController get snappingSheetController =>
      _snappingSheetController;

  set chargerCode(String value) => _chargerCode = value;

  void getUserLocation() =>
      Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
          .then((value) {
        cameraPosition = CameraPosition(
          target: LatLng(value.latitude, value.longitude),
          zoom: 14.4746,
        );
        notifyListeners();
        print(value.latitude);
      });
}
