import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';

class TopSheetViewModel extends BaseViewModel {
  String topSheetText = "Charging Started";
  int chargingState = 1;
  int batteryProcent = 100;
  int topSheetState = 1;
  double topSheetSize = 0.3;
  String stopChargingButtonText = "Stop Charging";
  String expandButtonText = "";
  String chargingAdress = "Kungsgatan 1a, Jönköping";
  String timeUntilFullyCharged = "1hr 21min until full";
  String kilowattHours = "5,72 kwh at 3kwh";

  void changeTopSheetState() {
    if (topSheetState < 3) {
      topSheetState += 1;
    } else {
      topSheetState = 1;
    }

    notifyListeners();
    changeTopSheetSize();
  }

  void changeTopSheetSize() {
    switch (topSheetState) {
      case 1:
        {
          topSheetSize = 0.35;
        }
        break;
      case 2:
        {
          topSheetSize = 0.45;
        }
        break;
      case 3:
        {
          topSheetSize = 0.6;
        }
        break;
    }
    notifyListeners();
  }

  void changeChargingState() {
    if (chargingState < 4) {
      chargingState += 1;
    } else {
      chargingState = 1;
      topSheetState = 3;
      changeTopSheetState();
    }

    switch (chargingState) {
      case 1:
        {
          topSheetText = "Charging Started";
          chargingState = 1;
        }
        break;
      case 2:
        {
          topSheetText = "Charging In Progress";
          stopChargingButtonText = "Stop Charging";
          expandButtonText = "Push to stop charging";
          chargingState = 2;
        }
        break;
      case 3:
        {
          topSheetText = "Fully Charged";
          stopChargingButtonText = "Disconnect";
          expandButtonText = "Push to disconnect";
          chargingState = 3;
        }
        break;
      case 4:
        {
          topSheetText = "Charging Summary";
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
