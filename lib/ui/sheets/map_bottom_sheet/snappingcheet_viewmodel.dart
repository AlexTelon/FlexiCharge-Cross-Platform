import 'package:flexicharge/app/app.locator.dart';
import 'package:flexicharge/models/charger.dart';
import 'package:flexicharge/models/charger_point.dart';
import 'package:flexicharge/models/transaction.dart';
import 'package:flexicharge/services/charger_api_service.dart';
import 'package:flexicharge/services/local_data.dart';
import 'package:flexicharge/services/transaction_api_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter/services.dart';
import 'dart:io' show Platform;

class CustomSnappingSheetViewModel extends BaseViewModel {
  final _chargerAPI = locator<ChargerApiService>();
  final _transactionAPI = locator<TransactionApiService>();
  final localData = locator<LocalData>();
  static const platform =
      const MethodChannel('com.startActivity/klarnaChannel');

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

  LatLng get userLocation => localData.userLocation;

  String chargerCode = '';
  List<Charger> chargers = [];
  List<LatLng> chargerLocations = [];

  List<ChargerPoint> get nearestLocation => localData.chargerPoints;
  bool get isSwishActive => _isSwishActive;
  bool get showWideButton => _showWideButton;
  bool get isFirstView => _isFirstView;
  bool get onlyPin => _onlyPin;

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
          'location': chargerPoints[i].name,
        });
      }
    } catch (e) {
      print(e);
    }
    return result;
  }

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
        onlyPin = false;

        notifyListeners();
      }
      notifyListeners();
    } catch (e) {
      selectedCharger = Charger();
      isFirstView = true;
    }
  }

  // Try to reserve a charger and get a transaction going
  Future<void> connect(int id, BuildContext context) async {
    if (selectedCharger.status == 'Available') {
      try {
        // Reserve charger during payment
        print("Trying to connect to a charger with id: $id...");
        //await _chargerAPI.reserveCharger(id); This API endpoint is not working
        print("charger is reserved");
        print("starting the session..");
        // Create a transaction session
        print("Trying to create a transaction session... ");
        Transaction transactionSession =
            await _transactionAPI.createKlarnaPaymentSession(null, id);
        localData.transactionSession = transactionSession;
        print("TransactionID: " +
            localData.transactionSession.transactionID.toString());
        print("clientToken: " +
            localData.transactionSession.clientToken.toString());

        print('Done');

        // Send our transaction session to klarna widget and wait for auth token
        print("transactionID:  " + transactionSession.transactionID.toString());
        print("Getting auth token...");

        String authToken =
            await _startKlarnaActivity(transactionSession.clientToken);
        print("authToken: " + authToken);

        print("auth token: " + authToken);

        if (Platform.isAndroid) {
          // Klarna iOS integration handles transaction start by itself,
          // however the Android integration does not.
          // Create transaction order with the auth token from klarna
          print(
              "Trying to update our transaction session with Klarna order... ");
          localData.transactionSession = await _transactionAPI
              .createKlarnaOrder(transactionSession.transactionID, authToken);
          print(
              "payment ID" + localData.transactionSession.paymentID.toString());
        }
      } catch (e) {
        print(e);
      }
    }
    notifyListeners();
  }

  // Try to disconnect the charger and update the transactionSession
  Future<void> disConnect(int id) async {
    try {
      // Reserve charger during payment
      print("trying to disconnect the charger...");
      localData.transactionSession = await _transactionAPI.stopCharging(id);
      print("charger is disconnected");
      print("paymentConfirmed: " +
          localData.transactionSession.paymentConfirmed.toString());
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  Future<String> _startKlarnaActivity(String clientToken) async {
    try {
      final String result = await platform
          .invokeMethod("StartKlarnaActivity", {'clientToken': clientToken});
      return result;
    } on PlatformException catch (e) {
      debugPrint("Error: '${e.message}'.");
      return '';
    }
  }
}
