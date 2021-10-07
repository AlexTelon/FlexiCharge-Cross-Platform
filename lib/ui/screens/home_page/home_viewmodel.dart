import 'dart:async';

import 'package:flexicharge/app/app.router.dart';
import 'package:flexicharge/models/charger_point.dart';
import 'package:flexicharge/app/app.locator.dart';
import 'package:flexicharge/enums/bottom_sheet_type.dart';
import 'package:flexicharge/services/charger_api_service.dart';
import 'package:flexicharge/services/local_data.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:geocoding/geocoding.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _chagerAPI = locator<ChargerApiService>();
  final localData = locator<LocalData>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _navigationService = locator<NavigationService>();

  init() async {
    try {
      getUserLocation();
      findUser();
      getAddress();

      localData.chargerPoints.forEach(
        (chargingPoint) => markers.add(
          Marker(
            markerId: MarkerId(chargingPoint.chargerPointId.toString()),
            icon: chargingPoint.chargers
                        .where((charger) => charger.status == "Available")
                        .length ==
                    chargingPoint.chargers.length
                ? localData.redMarkerIcon
                : localData.greenMarkerIcon,
            onTap: () => openFindCharger(chargerPointId: chargingPoint),
            position: chargingPoint.coordinates,
            consumeTapEvents: true,
          ),
        ),
      );
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  String title = '';
  Set<Marker> markers = {};
  bool activeTopSheet = false;

  Completer<GoogleMapController> controller = Completer();
  GoogleMapController? userLocateController;

  CameraPosition cameraPosition = CameraPosition(
    target: LatLng(0, 0),
  );

  void getUserLocation() {
    cameraPosition = CameraPosition(
      target: LatLng(
          localData.userLocation.latitude, localData.userLocation.longitude),
      zoom: 14.5,
    );
    notifyListeners();
  }

  Future<void> openFindCharger({ChargerPoint? chargerPointId}) async {
    _bottomSheetService
        .showCustomSheet(
            variant: SheetType.mapBottomSheet, data: chargerPointId)
        .then((value) {
      if (value != null && value.data == true) {
        activeTopSheet = true;
        notifyListeners();
      }
    });
  }

  Future<void> findUser() async {
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((value) async {
      cameraPosition = CameraPosition(
        target: LatLng(value.latitude, value.longitude),
        zoom: 17,
      );
      userLocateController
          ?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      notifyListeners();
    });
  }

  Future<void> getAddress() async {
    await placemarkFromCoordinates(
      localData.userLocation.latitude,
      localData.userLocation.longitude,
    );
    notifyListeners();
    print(placemarkFromCoordinates);
  }

  Future<void> doQrScan() async {
    // Open qr scan and wait for data
    await _navigationService.navigateTo(Routes.qrScannerView);
    // Pass data to charger code input field
    if (localData.qrCode.isNotEmpty) openChargerCodeInput(localData.qrCode);
  }

  Future<void> openChargerCodeInput(String? data) async {
    _bottomSheetService.showCustomSheet(
        variant: SheetType.mapBottomSheet, data: data);
  }

  completeTopSheet() {
    activeTopSheet = false;
    notifyListeners();
  }
}
