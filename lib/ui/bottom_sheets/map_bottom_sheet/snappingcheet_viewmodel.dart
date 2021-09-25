import 'package:flexicharge/app/app.locator.dart';
import 'package:flexicharge/models/charger.dart';
import 'package:flexicharge/models/charger_point.dart';
import 'package:flexicharge/services/charger_api_service.dart';
import 'package:flexicharge/services/local_data.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:geocoding/geocoding.dart' as geoCoder;

class CustomSnappingSheetViewModel extends BaseViewModel {
  final _chargerAPI = locator<ChargerApiService>();
  final localData = locator<LocalData>();

  init(SheetRequest request) async {
    if (request.data != null && request.data is ChargerPoint) {
      _selectedChargerPoint = request.data;
      notifyListeners();
    }
    localData.chargerPoints = await _chargerAPI.getChargerPoints();

    notifyListeners();
  }

  bool _isSwishActive = false;
  bool _showWideButton = false;
  Charger _selectedCharger = Charger();
  ChargerPoint _selectedChargerPoint = ChargerPoint();

  LatLng userLocation = LatLng(0, 0);

  String _chargerCode = '';
  List<Charger> chargers = [];
  List<ChargerPoint> get nearestLocation => localData.chargerPoints;
  List<LatLng> chargerLocations = [];

  bool get isSwishActive => _isSwishActive;
  bool get showWideButton => _showWideButton;

  set showWideButton(bool newState) {
    _showWideButton = newState;
    notifyListeners();
  }

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
    _selectedChargerPoint = ChargerPoint();
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



  ///getSortedChargerPoints function returns sorted nearest locations  type of [Map] and it containes { 
  ///       'chargerPoint': [String],
  ///       'distance': [String],
  ///       'location': [String]
  ///}
  List<Map<String, dynamic>> get getSortedChargerPoints {
    var chargerPoints = localData.chargerPoints;
    chargerPoints.sort((first, after) =>
        getDistance(userLocation, first.coordinates)
            .compareTo(getDistance(userLocation, after.coordinates)));

    List<Map<String, dynamic>> result = [];
    for (int i = 0; i < chargerPoints.length && i < 4; i += 1) {
      var distance = getDistance(
        userLocation,
        chargerPoints[i].coordinates,
      );

      result.add({
        'chargerPoint': chargerPoints[i],
        'distance': 1 <= distance % 1000
            ? '${(distance % 1000).toStringAsFixed(1)} KM'
            : '${distance.toStringAsFixed(1)} M',
        'location': chargerPoints[i].chargerPointId.toString(),
      });
      notifyListeners();
    }
    return result;
  }

  set chargerCode(String value) => _chargerCode = value;

  Future<List<Charger>> getChargers() => _chargerAPI.getChargers();

  Future<void> getChargerById(int id) async {
    selectedCharger = await _chargerAPI.getChargerById(id);
    notifyListeners();
  }

  Future<void> updateStatus(int status, int id, int chargePointID) async {
    await _chargerAPI.updateStatus(status, id, chargePointID);
    notifyListeners();
  }
}
