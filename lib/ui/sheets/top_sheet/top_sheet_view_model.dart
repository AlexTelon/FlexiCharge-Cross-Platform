import 'dart:async';

import 'package:flexicharge/app/app.locator.dart';
import 'package:flexicharge/enums/event_type.dart';
import 'package:flexicharge/enums/top_sheet_strings.dart';
import 'package:flexicharge/models/transaction.dart';
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
  DateTime? fullychargedTime;
  String stopTime = '';
  Timer? timer;

  /// The function starts a stream listener that listens for changes in the battery level and charging
  /// status. It also starts a timer that increments the charging percentage every second
  init() {
    startStreamListener();

    timer = Timer.periodic(
        Duration(seconds: 1), (Timer t) => incrementChargingPercentage());
  }

  /// If the charging percentage is less than 100, increment it by 1. If it's not, cancel the timer and
  /// change the charging state to true
  void incrementChargingPercentage() {
    if (localData.chargingPercentage < 100) {
      localData.chargingPercentage += 1;
      notifyListeners();
    } else {
      timer?.cancel();
      changeChargingState(true);
    }
  }

  /// A getter that returns the address of the charger.
  String get chargingAdress {
    /*var chargerPoint = localData.chargerPoints.firstWhere((element) => element
        .chargers
        .contains((charger) => charger.id == transactionSession.chargerID));
    */
    return 'Kungsgatan 1a, Jönköping';
  }

  /// Returns amount of seconds left until fully charged expressed as readable text
  String get timeUntilFullyCharged {
    var goal = 100;
    var percentage = transactionSession.currentChargePercentage;

    return '${(goal - percentage).toStringAsFixed(0)} seconds left';
  }

  String get kilowattHours =>
      "${transactionSession.kwhTransferred} kWh transferred";

  /// It changes the state of the top sheet and notifies the listeners
  ///
  /// Args:
  ///   state: The state of the top sheet.
  void changeTopSheetState(state) {
    topSheetState = state;
    notifyListeners();
    changeTopSheetSize();
  }

  Transaction get transactionSession => localData.transactionSession;

  /// It changes the size of the top sheet based on the state of the top sheet
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

  /// It's a function that is called every second to update the charging state of the app
  ///
  /// Args:
  ///   finishedCharging (bool): A boolean that determines whether the charging has finished or not.
  Future<void> changeChargingState(bool finishedCharging) async {
    if (finishedCharging) {
      print("Stopping timer...");
      //localData.timer.cancel();
      chargingState = 4;
      changeTopSheetState(3);
      try {
        await transactionApiService
            .stopCharging(localData.transactionSession.transactionID);
      } catch (error) {
        print("Could not stop charging");
      }
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

  /// It takes an integer as an argument and based on the integer value, it changes the value of the
  /// variables that are used to display the text on the screen
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

  /// Listening to the stream and if the event is stopTimer, it will change the charging state to false
  /// and notify the listeners. If the event is showCharging, it will change the charging state to false.
  void startStreamListener() {
    localData.stream.listen((event) {
      if (event == EventType.stopTimer) {
        changeChargingState(false);
        stopTime = '${DateTime.now().hour} :${DateTime.now().minute} ';
        notifyListeners();
      } else if (event == EventType.showCharging) {
        changeChargingState(false);
      }
    });
  }
}

/// It's an extension method that is used to parse the time difference between two dates.
extension TimeParser on int {
  DateTime parseUNIXTimestamp() {
    return DateTime.fromMicrosecondsSinceEpoch(this * 1000);
  }

  String parseTimeDiff() {
    var date = DateTime.fromMicrosecondsSinceEpoch(this);
    var now = DateTime.now();
    var duration = now.difference(date);
    var result = '';

    if (duration.inHours % 24 > 0) {
      result = result + (duration.inHours % 24).toString() + 'hr ';
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
