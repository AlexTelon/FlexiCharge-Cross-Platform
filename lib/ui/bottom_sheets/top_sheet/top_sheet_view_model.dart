import 'dart:async';

import 'package:flexicharge/app/app.locator.dart';
import 'package:flexicharge/enums/top_sheet_strings.dart';
import 'package:flexicharge/models/transaction.dart';
import 'package:flexicharge/services/charger_api_service.dart';
import 'package:flexicharge/services/local_data.dart';
import 'package:stacked/stacked.dart';
import 'package:intl/intl.dart';

class TopSheetViewModel extends BaseViewModel {
  final chargerApiService = locator<ChargerApiService>();
  String topSheetText = TopSheetString.chargingStarted.name;
  int chargingState = 1;
  int batteryPercent = 75;
  int topSheetState = 1;
  double topSheetSize = 0.3;
  String stopChargingButtonText = "";
  String expandButtonText = "";
  late Timer timer;
  DateTime? fullychargedTime;

  final localData = locator<LocalData>();

  // Dummy data
  String get chargingAdress {
    var chargerPoint = localData.chargerPoints.firstWhere((element) => element
        .chargers
        .contains((charger) => charger.id == transactionSession.chargerID));

    return chargerPoint.name;
  }

  String get timeUntilFullyCharged {
    var goal = 100;
    var percentage = transactionSession.currentChargePercentage;

    return '${(goal - percentage).toStringAsFixed(0)} seconds left';
  }

  String get kilowattHours =>
      "${transactionSession.kwhTransfered} kWh transferred";

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Transaction get transactionSession => localData.transactionSession;

  void updatebatteryPercent() {
    var percent = 0;
    timer = new Timer.periodic(Duration(seconds: 2), (timer) {
      if (batteryPercent < 100) {
        percent += 1;
      } else {
        timer.cancel();
      }
      batteryPercent = percent;
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

  Future<void> changeChargingState(bool finishedCharging) async {
    if (finishedCharging) {
      chargingState = 4;
      changeTopSheetState(3);
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
          batteryPercent = 75;
          chargingState = 2;
        }
        break;
      case 3:
        {
          topSheetText = TopSheetString.fullyCharged.name;
          stopChargingButtonText = TopSheetString.disconnect.name;
          expandButtonText = TopSheetString.pushToDisconnect.name;
          batteryPercent = 100;
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

extension TimeParser on int {
  DateTime parseUNIXTimestamp() {
    return DateTime.fromMicrosecondsSinceEpoch(this * 1000);
  }

  String parseTimeDiff() {
    var date = DateTime.fromMicrosecondsSinceEpoch(this * 1000);
    var now = DateTime.now();
    var duration = now.difference(date);
    var result = '';

    if (duration.inHours % 24 > 0) {
      result = result + duration.inHours.toString() + 'hr ';
    }
    if (duration.inMinutes % 60 > 0) {
      result = result + (duration.inMinutes % 60).toString() + 'min ';
    }
    if (duration.inSeconds % 60 > 0) {
      result = result + (duration.inMinutes % 60).toString() + 'sec ';
    }

    return result;
  }
}
