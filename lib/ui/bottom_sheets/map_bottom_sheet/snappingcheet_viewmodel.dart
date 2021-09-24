import 'package:flexicharge/app/app.locator.dart';
import 'package:flexicharge/models/charger.dart';
import 'package:flexicharge/models/charger_point.dart';
import 'package:flexicharge/services/charger_api_service.dart';
import 'package:flexicharge/services/local_data.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';

class CustomSnappingSheetViewModel extends BaseViewModel {
  final _chargerAPI = locator<ChargerApiService>();
  final localData = locator<LocalData>();
  bool _isSwishActive = false;
  Charger _selectedCharger = Charger();
  ChargerPoint _selectedChargerPoint = ChargerPoint();
  List<LatLng> chargerCoordinates = [];

  LatLng userLocation = LatLng(0, 0);

  String _chargerCode = '';
  List<Charger> chargers = [];
  //List<Charger> get nearestLocation => localData.chargers;
  List<LatLng> chargerLocations = [];

  bool get isSwishActive => _isSwishActive;

  set isSwishActive(bool newState) {
    _isSwishActive = newState;
    notifyListeners();
  }

  Charger get selectedCharger => _selectedCharger;
  ChargerPoint get selectedChargerPoint => _selectedChargerPoint;

  Color get wideButtonColor {
    if (selectedCharger.status == 1)
      return Color.fromRGBO(120, 189, 118, 1);
    else if (selectedCharger.status == 0)
      return Color.fromRGBO(239, 96, 72, 1);
    else
      return Color.fromRGBO(229, 229, 229, 1);
  }

  String get wideButtonText {
    if (selectedCharger.status == 1)
      return 'Begin Charging';
    else if (selectedCharger.status == 0)
      return 'Charger Occupied';
    else
      return 'Charger Not Identified';
  }

  set selectedCharger(Charger newCharger) {
    _selectedCharger = newCharger;
    notifyListeners();
  }

  set selectedChargerPoint(ChargerPoint newChargerPoint) {
    _selectedChargerPoint = newChargerPoint;
    notifyListeners();
  }

  void changWideget() {
    _selectedCharger = Charger();
    notifyListeners();
  }

  void getUserLocation() =>
      Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
          .then((value) {
        userLocation = LatLng(value.latitude, value.longitude);
      });

  //function to calculate the distance between two points
  double getDistance(LatLng userLocation, LatLng chargerPoint) {
    double distanceInMeters = Geolocator.distanceBetween(userLocation.latitude,
        userLocation.longitude, chargerPoint.latitude, chargerPoint.longitude);
    return distanceInMeters / 1000;
  }

  List<Map<String, dynamic>> get getSortedChargerPoints {
    var chargerPoints = localData.chargerPoints;
    chargerPoints.sort((first, after) =>
        getDistance(userLocation, first.coordinates)
            .compareTo(getDistance(userLocation, after.coordinates)));

    List<Map<String, dynamic>> result = [];
    for (int i = 0; i <= chargerPoints.length && i < 4; i += 1) {
      result.add(
        {
          'ChargerPoint': chargerPoints[i],
          'Distance': getDistance(userLocation, chargerPoints[i].coordinates),
        },
      );
    }
    return result;
  }

  set chargerCode(String value) => _chargerCode = value;
  /* === Dummy Data ===  */
  // void getChargers() {
  //   chargers = localData.chargers
  //       .where(
  //         (charger) =>
  //             charger.id ==
  //             int.parse(
  //               _chargerCode,
  //             ),
  //       )
  //       .toList();
  //   notifyListeners();
  // }

  Future<List<Charger>> getChargers() => _chargerAPI.getChargers();

  Future<void> getChargerById(int id) async {
    selectedCharger = await _chargerAPI.getChargerById(id);
    notifyListeners();
  }
/*
  void getChargersFromNearest() {
    chargers = localData.chargers
        .where(
          (charger) => charger.id == selectedCharger.id,
        )
        .toList();
    notifyListeners();
  }
  */
}
