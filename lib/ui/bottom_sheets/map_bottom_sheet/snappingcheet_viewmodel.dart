import 'package:flexicharge/app/app.locator.dart';
import 'package:flexicharge/models/charger.dart';
import 'package:flexicharge/models/charger_point.dart';
import 'package:flexicharge/models/transaction_session.dart';
import 'package:flexicharge/services/charger_api_service.dart';
import 'package:flexicharge/services/local_data.dart';
import 'package:flexicharge/services/transaction_api_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter/services.dart';


class CustomSnappingSheetViewModel extends BaseViewModel {
  final _chargerAPI = locator<ChargerApiService>();
  final _transactionAPI = locator<TransactionApiService>();
  final localData = locator<LocalData>();
  static const platform = const MethodChannel('com.startActivity/klarnaChannel');

  init(SheetRequest request) async {
    if (request.data != null && request.data is ChargerPoint) {
      _selectedChargerPoint = request.data;
      _isFirstView = false;
      _onlyPin = false;
      notifyListeners();
    } else if (request.data != null && request.data is String) {
      chargerCode = request.data;
      try {
        await getChargerById(int.parse(request.data));
        _selectedChargerPoint = localData.chargerPoints
            .where((element) =>
                element.chargerPointId == _selectedCharger.chargerPointId)
            .first;
        _isFirstView = false;
        _onlyPin = false;
        _showWideButton = true;
        notifyListeners();
      } catch (e) {
        // Notify error...
        selectedCharger = Charger();
        selectedChargerPoint = ChargerPoint();
        showWideButton = true;
      }
    }
  }

  bool _isSwishActive = false;
  bool _showWideButton = false;
  bool _isFirstView = true;
  bool _onlyPin = true;

  Charger _selectedCharger = Charger();
  ChargerPoint _selectedChargerPoint = ChargerPoint();

  LatLng userLocation = LatLng(0, 0);

  String _chargerCode = '';
  List<Charger> chargers = [];
  List<LatLng> chargerLocations = [];

  List<ChargerPoint> get nearestLocation => localData.chargerPoints;
  bool get isSwishActive => _isSwishActive;
  bool get showWideButton => _showWideButton;
  bool get isFirstView => _isFirstView;
  bool get onlyPin => _onlyPin;
  String get chargerCode => _chargerCode;

  set showWideButton(bool newState) {
    _showWideButton = newState;
    notifyListeners();
  }

  set isSwishActive(bool newState) {
    _isSwishActive = newState;
    notifyListeners();
  }

  set isFirstView(bool newState) {
    _isFirstView = newState;
    notifyListeners();
  }

  set onlyPin(bool newState) {
    _onlyPin = newState;
    notifyListeners();
  }

  Charger get selectedCharger => _selectedCharger;
  ChargerPoint get selectedChargerPoint => _selectedChargerPoint;

  Color get wideButtonColor {
    if (selectedCharger.status == "Available")
      return Color.fromRGBO(120, 189, 118, 1);
    else if (selectedCharger.status == "Unavailable")
      return Color.fromRGBO(239, 96, 72, 1);
    else
      return Color.fromRGBO(229, 229, 229, 1);
  }

  String get wideButtonText {
    switch (selectedCharger.status) {
      case "Available":
        return 'Begin Charging';
      case "Occupied":
        return "Charger Occupied";
      case "Faulted":
        return "Charger Faulted";
      case "Rejected":
        return "Charger Unavailable";
      case "Unavailable":
        return "Charger Unavailable";
      case "Reserved":
        return "Charger Reserved";
      default:
        return 'Charger Not Identified';
    }
  }

  set selectedCharger(Charger newCharger) {
    _selectedCharger = newCharger;
    chargerCode = _selectedCharger.id.toString();
    _chargerAPI.getChargerById(newCharger.id);
    notifyListeners();
  }

  set selectedChargerPoint(ChargerPoint newChargerPoint) {
    _selectedChargerPoint = newChargerPoint;
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
    try {
      for (int i = 0; i < chargerPoints.length && i < 4; i += 1) {
        var distance = getDistance(
          userLocation,
          chargerPoints[i].coordinates,
        );

        result.add({
          'chargerPoint': chargerPoints[i],
          'distance': 1 <= distance % 1000
              ? '${(distance % 1000).toStringAsFixed(1)} km'
              : '${distance.toStringAsFixed(1)} m',
          'location': '',
        });
      }
    } catch (e) {
      print(e);
    }
    return result;
  }

  set chargerCode(String value) => _chargerCode = value;

  Future<List<Charger>> getChargers() => _chargerAPI.getChargers();

  Future<void> getChargerById(int id) async {
    try {
      selectedCharger = await _chargerAPI.getChargerById(id);
      selectedChargerPoint = localData.chargerPoints
          .where((element) =>
              element.chargerPointId == selectedCharger.chargerPointId)
          .first;
      if (selectedCharger.status == "Available") {
        isFirstView = false;
        showWideButton = true;
        notifyListeners();
      }
      notifyListeners();
    } catch (e) {
      selectedCharger = Charger();
      isFirstView = true;
    }
  }

  Future<void> updateStatus(int id) async {
    if (selectedCharger.status == 'Available') {
      bool value = await _chargerAPI.reserveCharger(id);
      if (value) {
        TransactionSession response =
            await _transactionAPI.createKlarnaPaymentSession(null, id);
        // Do something with the response... (Display Klarna Widget)
        localData.transactionSession = response;
        // start klarna activity
        var authorizationToken = await _startKlarnaActivity(response.clientToken);

      }
    }
    notifyListeners();
  }

  Future<String> _startKlarnaActivity(String clientToken) async {
    try {
      final String result = await platform.invokeMethod("StartKlarnaActivity",{
        'clientToken': clientToken
      });

      debugPrint('Result: $result ');
      return result;
    } on PlatformException catch (e) {
      debugPrint("Error: '${e.message}'.");
      return '';
    }
  }

}
