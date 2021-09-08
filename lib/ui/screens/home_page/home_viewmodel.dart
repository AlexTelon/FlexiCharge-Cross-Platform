import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  init() {
    getUserLocation();
  }

  String title = '';
  Completer<GoogleMapController> controller = Completer();
  final SnappingSheetController _snappingSheetController = SnappingSheetController();

  SnappingSheetController get snappingSheetController => _snappingSheetController;

  CameraPosition cameraPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  void getUserLocation() =>
      Geolocator.getPositionStream(desiredAccuracy: LocationAccuracy.high)
          .listen((value) {
        cameraPosition = CameraPosition(
          target: LatLng(value.latitude, value.longitude),
          zoom: 14.4746,
        );
        notifyListeners();
        print(value.latitude);
      });
}
