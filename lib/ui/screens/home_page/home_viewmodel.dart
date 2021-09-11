import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  init() async {
    getUserLocation();
    greenMarkerIcon = await _greenMarkerIcon;
    redMarkerIcon = await _redMarkerIcon;
    notifyListeners();
  }

  BitmapDescriptor greenMarkerIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor redMarkerIcon = BitmapDescriptor.defaultMarker;
  String title = '';

  Completer<GoogleMapController> controller = Completer();
  final SnappingSheetController _snappingSheetController =
      SnappingSheetController();

  SnappingSheetController get snappingSheetController =>
      _snappingSheetController;

  CameraPosition cameraPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.5,
  );

  void getUserLocation() =>
      Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.medium)
          .then((value) {
        cameraPosition = CameraPosition(
          target: LatLng(value.latitude, value.longitude),
          zoom: 16.5,
        );
        notifyListeners();
        print(value.latitude);
      });

  get _greenMarkerIcon => BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(25, 25)),
        'assets/images/greenMarker.png',
      );

  get _redMarkerIcon => BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(25, 25)),
        'assets/images/redMarker.png',
      );
}
