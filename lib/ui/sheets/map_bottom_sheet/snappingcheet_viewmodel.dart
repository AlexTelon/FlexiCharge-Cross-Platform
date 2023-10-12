import 'dart:async';
import 'package:flexicharge/app/app.locator.dart';
import 'package:flexicharge/models/charger.dart';
import 'package:flexicharge/models/charger_point.dart';
import 'package:flexicharge/models/transaction.dart';
import 'package:flexicharge/services/charger_api_service.dart';
import 'package:flexicharge/services/local_data.dart';
import 'package:flexicharge/services/transaction_api_service.dart';
import 'package:flexicharge/services/user_api_service.dart';
import 'package:flexicharge/theme.dart';
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
  String userStreetLocation = "";

  /// If the data is a ChargerPoint, then set the selectedChargerPoint to the data.
  /// If the data is a String, then get the charger by the id and
  /// set the selectedChargerPoint to the chargerPointId of the selectedCharger
  ///
  /// Args:
  ///   request (SheetRequest): The request object that is passed to the view model.
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

  /// The function `updateUserAddress` updates the `userAddress` variable based on the `userLocation` and
  /// notifies listeners of the change.
  Future<void> updateUserAddress() async {
    try {
      final String? address =
          await UserApiService().getAddressFromCoordinates(userLocation);
      if (address != null) {
        userStreetLocation = address;
        notifyListeners(); // Notify listeners that userAddress has been updated
      }
    } catch (e) {
      print('Error updating user address: $e');
    }
  }

  bool _isKlarnaActive = false;
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
  bool get isSwishActive => _isKlarnaActive;
  bool get showWideButton => _showWideButton;
  bool get isFirstView => _isFirstView;
  bool get onlyPin => _onlyPin;

  set showWideButton(bool newState) {
    _showWideButton = newState;
    notifyListeners();
  }

  set isSwishActive(bool newState) {
    _isKlarnaActive = newState;
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

  /// A getter function that returns a color based on the status of the charger.
  Color get wideButtonColor {
    if (selectedCharger.status == "Available")
      return FlexiChargeTheme.green;
    else if (selectedCharger.status == "Unavailable")
      return FlexiChargeTheme.red;
    else
      return FlexiChargeTheme.lightGrey;
  }

  /// A getter function that returns a string based on the status of the charger.
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

  /// The `shouldStartCharging` getter function is used to determine whether the charging process should
  /// be started or not. It checks the status of the selected charger and returns `true` if the status
  /// is "Available", indicating that the charger is available for charging. Otherwise, it returns
  /// `false`. This getter function can be used to conditionally enable or disable the charging
  /// functionality based on the status of the charger.
  bool get shouldStartCharging {
    switch (selectedCharger.status) {
      case "Available":
        return true;
      default:
        return false;
    }
  }

  /// Setting the selected charger to the new charger and then it is setting
  /// the charger code to the id of the charger. Then it is calling the
  /// getChargerById function with the id of the charger.
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

  /// getSortedChargerPoints function returns sorted nearest locations type
  /// of [Map] and it containes
  /// {
  ///       'chargerPoint': [String],
  ///       'distance': [String],
  ///       'location': [String]
  ///}
  List<Map<String, dynamic>> get getSortedChargerPoints {
    var chargerPoints = localData.chargerPoints;
    chargerPoints.sort((first, after) =>
        getDistance(userLocation, first.location)
            .compareTo(getDistance(userLocation, after.location)));

    List<Map<String, dynamic>> result = [];
    try {
      for (int i = 0; i < chargerPoints.length && i < 4; i += 1) {
        var distance = getDistance(
          userLocation,
          chargerPoints[i].location,
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

  /// It gets a charger by its id, and if the charger is available, it sets the
  /// isFirstView to false, showWideButton to true, and onlyPin to false
  ///
  /// Args:
  ///   id (int): the id of the charger
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
            localData.transactionSession.klarnaClientToken.toString());

        print('Done');

        // Send our transaction session to klarna widget and wait for auth token
        print("transactionID:  " + transactionSession.transactionID.toString());
        print("Getting auth token...");

        String authToken =
            await _startKlarnaActivity(transactionSession.klarnaClientToken);
        print("authToken: " + authToken);

        print("auth token: " + authToken);

        if (Platform.isAndroid) {
          // Klarna iOS integration handles transaction start by itself,
          // however the Android integration does not.
          // Create transaction order with the auth token from klarna
          print(
              "Trying to update our transaction session with Klarna order... ");
          await _transactionAPI.createKlarnaOrder(
              transactionSession.transactionID, authToken);

          Transaction specificTransaction = await _transactionAPI
              .getTransactionById(transactionSession.transactionID);
          localData.transactionSession.updateFrom(specificTransaction);

          print("payment ID" +
              localData.transactionSession.klarnaSessionID.toString());
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
      Transaction stoppedChargingSession =
          await _transactionAPI.stopCharging(id);
      localData.transactionSession.updateFrom(stoppedChargingSession);
      print("charger is disconnected");
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  /// It calls the native code and passes the client token as a parameter
  ///
  /// Args:
  ///   clientToken (String): The client token you get from the server.
  ///
  /// Returns:
  ///   The result is a JSON string that contains the payment method and the
  ///   payment method details.
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
