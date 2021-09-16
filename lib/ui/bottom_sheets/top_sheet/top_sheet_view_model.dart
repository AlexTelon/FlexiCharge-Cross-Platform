import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';

class TopSheetViewModel extends BaseViewModel {
  String topSheetText = "";
  int chargingState = 0;
  int batteryProcent = 100;
  int topSheetState = 1;
  double topSheetSize = 0.3;
  String chargingAdress = "Kungsgatan 1a, Jönköping";
  String timeUntilFullyCharged = "1hr 21min until full";
  String kilowattHours = "5,72 kwh at 3kwh";

  void testTopSheet() {
    if (chargingState < 4) {
      chargingState += 1;
    } else {
      chargingState = 0;
    }

    print(chargingState);
    notifyListeners();
    changeChargingState();
  }

  void changeTopSheetSize() {
    if (topSheetState < 3) {
      topSheetState += 1;
    } else {
      topSheetState = 1;
    }

    switch (topSheetState) {
      case 1:
        {
          topSheetSize = 0.35;
        }
        break;
      case 2:
        {
          topSheetSize = 0.4;
        }
        break;
      case 3:
        {
          topSheetSize = 0.5;
        }
        break;
    }
    notifyListeners();
  }

  void changeChargingState() {
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
          chargingState = 2;
        }
        break;
      case 3:
        {
          topSheetText = "Fully Charged";
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
          chargingState = 0;
        }
        break;
    }
    notifyListeners();
  }
}
