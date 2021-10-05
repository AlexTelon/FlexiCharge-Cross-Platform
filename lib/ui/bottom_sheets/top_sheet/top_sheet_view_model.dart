import 'dart:async';

import 'package:flexicharge/enums/top_sheet_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';

class TopSheetViewModel extends BaseViewModel {
  String topSheetText = TopSheetString.chargingStarted.name;
  int chargingState = 1;
  int batteryProcent = 75;
  int topSheetState = 1;
  double topSheetSize = 0.3;
  String stopChargingButtonText = "";
  String expandButtonText = "";
  late Timer timer;

  // Dummy data
  String chargingAdress = "Kungsgatan 1a, Jönköping";
  String timeUntilFullyCharged = "1hr 21min until full";
  String kilowattHours = "5,72 kwh at 3kwh";

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void updateBatteryProcent(int procent) {
    timer = new Timer.periodic(Duration(seconds: 1), (timer) {
      procent++;
      batteryProcent = procent;
      notifyListeners();
    });
  }

  void changeTopSheetState(state) {
    topSheetState = state;
    notifyListeners();
    changeTopSheetSize();
  }

  void changeTopSheetSize() {
    switch (topSheetState) {
      case 1:
        {
          topSheetSize = 0.30;
        }
        break;
      case 2:
        {
          topSheetSize = 0.45;
        }
        break;
      case 3:
        {
          topSheetSize = 0.60;
        }
        break;
    }
    notifyListeners();
  }

  void changeChargingState(bool finishedCharging) {
    if (finishedCharging) {
      chargingState = 4;
      changeTopSheetState(3);
    } else {
      if (chargingState < 3) {
        chargingState += 1;
      } else {
        chargingState = 1;
        changeTopSheetState(1);
      }
    }

    notifyListeners();
    displayChargingState();
  }

  void displayChargingState() {
    switch (chargingState) {
      case 1:
        {
          topSheetText = TopSheetString.chargingStarted.name;
          chargingState = 1;
        }
        break;
      case 2:
        {
          topSheetText = TopSheetString.chargingInProgress.name;
          stopChargingButtonText = TopSheetString.stopCharging.name;
          expandButtonText = TopSheetString.pushToStopCharging.name;
          batteryProcent = 75;
          chargingState = 2;
        }
        break;
      case 3:
        {
          topSheetText = TopSheetString.fullyCharged.name;
          stopChargingButtonText = TopSheetString.disconnect.name;
          expandButtonText = TopSheetString.pushToDisconnect.name;
          batteryProcent = 100;
          chargingState = 3;
        }
        break;
      case 4:
        {
          topSheetText = TopSheetString.chargingSummary.name;
          chargingState = 4;
        }
        break;
      default:
        {
          topSheetText = "";
          chargingState = 1;
          topSheetState = 1;
          changeTopSheetSize();
        }
        break;
    }

    notifyListeners();
  }
}
