import 'dart:async';

import 'package:flexicharge/app/app.locator.dart';
import 'package:flexicharge/enums/event_type.dart';
import 'package:flexicharge/enums/top_sheet_strings.dart';
import 'package:flexicharge/services/charger_api_service.dart';
import 'package:flexicharge/services/local_data.dart';
import 'package:flexicharge/services/transaction_api_service.dart';
import 'package:stacked/stacked.dart';

class TopSheetViewModel extends BaseViewModel {
  final chargerApiService = locator<ChargerApiService>();
  final transactionApiService = locator<TransactionApiService>();
  final localData = locator<LocalData>();
  String topSheetText = TopSheetString.chargingStarted.name;
  int chargingState = 1;
  int topSheetState = 1;
  double topSheetSize = 0.3;
  String stopChargingButtonText = "";
  String expandButtonText = "";

  init() {
    streamListener();
  }

  // Dummy data
  String chargingAdress = "Kungsgatan 1a, Jönköping";
  String timeUntilFullyCharged = "1hr 21min until full";
  String kilowattHours = "5,72 kwh at 3kwh";

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

  Future<void> changeChargingState(bool finishedCharging) async {
    if (finishedCharging) {
      print("Stopping timer...");
      localData.timer.cancel();
      chargingState = 4;
      changeTopSheetState(3);
      transactionApiService
          .stopCharging(localData.transactionSession.transactionID);
      chargerApiService.updateStatus("Available", localData.chargingCharger);
      localData.isButtonActive = true;
      localData.chargerPoints = await chargerApiService.getChargerPoints();
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
          chargingState = 2;
        }
        break;
      case 3:
        {
          topSheetText = TopSheetString.fullyCharged.name;
          stopChargingButtonText = TopSheetString.disconnect.name;
          expandButtonText = TopSheetString.pushToDisconnect.name;
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

  void streamListener() {
    localData.stream.listen((event) {
      if (event == EventType.stopTimer) {
        changeChargingState(false);
      } else if (event == EventType.showCharging) {
        changeChargingState(false);
      }
    });
  }
}
