import 'package:flexicharge/app/app.locator.dart';
import 'package:flexicharge/app/app.router.dart';
import 'package:flexicharge/services/charger_api_service.dart';
import 'package:flexicharge/services/local_data.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../models/user_secure_storage.dart';

class LaunchViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _localData = locator<LocalData>();
  final _chagerAPI = locator<ChargerApiService>();

  double _indication = 0.95;
  double get indication => _indication;
  set indication(double newIndication) {
    _indication = newIndication;
    notifyListeners();
  }

  init() async {
    try {
      await getUserLocation();
      indication = 0.9;

      _localData.greenMarkerIcon = await _greenMarkerIcon;
      _localData.redMarkerIcon = await _redMarkerIcon;
      _localData.blackMarkerIcon = await _blackMarkerIcon;
      indication = 0.7;
      _localData.chargerPoints = await _chagerAPI.getChargerPoints();
      indication = 0;
      if (await UserSecureStorage.getUserIsLoggedIn()) {
        _navigationService.replaceWith(
          Routes.homeView,
        );
      } else {
        _navigationService.replaceWith(
          Routes.registrationView,
        );
      }
    } catch (e) {
      print(e);
    }
  }

  get _greenMarkerIcon => BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(25, 25)),
        'assets/images/green_marker.png',
      );

  get _redMarkerIcon => BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(25, 25)),
        'assets/images/red_marker.png',
      );

  get _blackMarkerIcon => BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(25, 25)),
        'assets/images/black_marker.png',
      );

  Future<void> getUserLocation() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.reduced);
    _localData.userLocation = LatLng(position.latitude, position.longitude);
  }
}
