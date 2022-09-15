import 'dart:async';
import 'package:flexicharge/enums/event_type.dart';
import 'package:flexicharge/models/transaction.dart';
import 'package:flexicharge/services/transaction_api_service.dart';
import 'package:flexicharge/app/app.router.dart';
import 'package:flexicharge/models/charger_point.dart';
import 'package:flexicharge/app/app.locator.dart';
import 'package:flexicharge/enums/bottom_sheet_type.dart';
import 'package:flexicharge/services/charger_api_service.dart';
import 'package:flexicharge/services/local_data.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _chagerAPI = locator<ChargerApiService>();
  final _transactionAPI = locator<TransactionApiService>();
  final localData = locator<LocalData>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _navigationService = locator<NavigationService>();

  init() async {
    try {
      getUserLocation();
      findUser();

      localData.chargerPoints.forEach(
        (chargingPoint) => markers.add(
          Marker(
            markerId: MarkerId(chargingPoint.chargerPointId.toString()),
            icon: chargingPoint.chargers
                        .where((charger) => charger.status != 'Available')
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
        startTimer();
        notifyListeners();
      }
    });
  }

  void startTimer() {
    print("Starting timer...");
    int secondsPast = 0;
    localData.chargingPercentage = 0;

    localData.timer = new Timer.periodic(Duration(seconds: 2), (timer) async {
      secondsPast += 2;
      localData.chargingPercentage = await fetchChargingPercentage();

      if (secondsPast == 2) {
        // Change to ChargeInProgress state when 2 seconds has past.
        localData.controller.add(EventType.showCharging);
      }

      if (localData.chargingPercentage == 100) {
        print("Fully charged! Stopping timer...");
        localData.controller.add(EventType.stopTimer);
        localData.timer.cancel();
      }

      print("Seconds: " +
          secondsPast.toString() +
          "Charging Percentage: " +
          localData.chargingPercentage.toString());
      notifyListeners();
    });
  }

  Future<int> fetchChargingPercentage() async {
    try {
      Transaction currentTransaction = await _transactionAPI
          .getTransactionById(localData.transactionSession.transactionID);

      int currentChargingPercentage =
          currentTransaction.currentChargePercentage.round();
      return currentChargingPercentage;
    } catch (e) {
      print(e);
    }

    return 0;
  }

  Future<void> getTransaction() async {
    // Testing transactionApiService
    var transaction = await _transactionAPI.getTransactionById(1);
    // transaction.printTransaction();
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
